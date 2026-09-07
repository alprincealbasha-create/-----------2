import {
  callerClient,
  jsonHeaders,
  serviceClient,
} from '../_shared/clients.ts';
import {
  changeMembershipAndRevoke,
  provisionWithCompensation,
  resetPinAndRevoke,
} from './workflow.ts';

const forbidden = () => new Response(
  JSON.stringify({ error: 'not_authorized' }),
  { status: 403, headers: jsonHeaders },
);

Deno.serve(async (request) => {
  if (request.method !== 'POST') {
    return new Response(null, { status: 405, headers: jsonHeaders });
  }
  const authorization = request.headers.get('authorization');
  if (!authorization?.startsWith('Bearer ')) return forbidden();

  let body: Record<string, unknown>;
  try {
    body = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: 'invalid_request' }), {
      status: 400,
      headers: jsonHeaders,
    });
  }

  const action = String(body.action ?? '');
  const role = String(body.role ?? '');
  const organizationId = String(body.organization_id ?? '');
  const branchId = body.branch_id == null ? null : String(body.branch_id);
  const classId = body.class_id == null ? null : String(body.class_id);
  const caller = callerClient(authorization);
  const { data: actorData, error: actorError } = await caller.auth.getUser(
    authorization.slice(7),
  );
  if (actorError || !actorData.user) return forbidden();

  const targetProfileId = body.profile_id == null ? null : String(body.profile_id);
  const permissionRequest = action === 'provision'
    ? caller.rpc('authorize_membership_administration', {
      target_organization_id: organizationId,
      target_branch_id: branchId,
      target_role: role,
    })
    : caller.rpc('authorize_existing_membership_administration', {
      target_profile_id: targetProfileId,
      desired_branch_id: branchId,
      desired_role: role,
    });
  const { data: allowed, error: permissionError } = await permissionRequest;
  if (permissionError || allowed !== true) return forbidden();

  const service = serviceClient();

  if (action === 'update') {
    const result = await changeMembershipAndRevoke(
      async () => {
        const { error } = await service.rpc('change_membership_record', {
          target_profile_id: targetProfileId,
          desired_branch_id: branchId,
          desired_class_id: classId,
          desired_role: role,
          desired_status: String(body.status ?? ''),
          change_actor_id: actorData.user.id,
        });
        return error == null;
      },
      () => revokeSessions(targetProfileId!),
      () => recordRevocationFailure(
        service,
        targetProfileId!,
        actorData.user.id,
        'membership_update',
      ),
    );
    if (!result.ok) {
      return new Response(JSON.stringify({ error: result.error }), {
        status: result.status, headers: jsonHeaders,
      });
    }
    return new Response(null, { status: 204, headers: jsonHeaders });
  }

  if (action === 'reset_pin') {
    const pin = String(body.pin ?? '');
    if (role !== 'student' || !targetProfileId || !/^\d{6}$/.test(pin)) {
      return new Response(JSON.stringify({ error: 'invalid_request' }), {
        status: 400, headers: jsonHeaders,
      });
    }
    const { data: target, error: targetError } = await service
      .from('profiles').select('role').eq('id', targetProfileId).single();
    if (targetError || target?.role !== 'student') return forbidden();
    const result = await resetPinAndRevoke(
      async () => {
        const { error } = await service.auth.admin.updateUserById(
          targetProfileId,
          { password: pin },
        );
        return error == null;
      },
      async () => {
        const { error } = await service.rpc('complete_student_pin_reset', {
          target_profile_id: targetProfileId,
          reset_actor_id: actorData.user.id,
        });
        return error == null;
      },
      () => revokeSessions(targetProfileId),
      () => recordRevocationFailure(
        service,
        targetProfileId,
        actorData.user.id,
        'pin_reset',
      ),
    );
    if (!result.ok) {
      return new Response(JSON.stringify({ error: result.error }), {
        status: result.status, headers: jsonHeaders,
      });
    }
    return new Response(null, { status: 204, headers: jsonHeaders });
  }

  if (action !== 'provision') {
    return new Response(JSON.stringify({ error: 'unsupported_action' }), {
      status: 400,
      headers: jsonHeaders,
    });
  }

  const student = role === 'student';
  const password = String(student ? body.pin ?? '' : body.password ?? '');
  if ((student && !/^\d{6}$/.test(password)) || (!student && password.length < 8)) {
    return new Response(JSON.stringify({ error: 'invalid_credentials_format' }), {
      status: 400,
      headers: jsonHeaders,
    });
  }

  const authEmail = student
    ? `student-${crypto.randomUUID()}@auth.invalid`
    : String(body.email ?? '').trim().toLowerCase();
  if (!authEmail.includes('@')) {
    return new Response(JSON.stringify({ error: 'invalid_email' }), {
      status: 400,
      headers: jsonHeaders,
    });
  }

  const result = await provisionWithCompensation(
    async () => {
      const { data, error } = await service.auth.admin.createUser({
        email: authEmail,
        password,
        email_confirm: true,
      });
      return error == null ? data.user?.id ?? null : null;
    },
    async (userId) => {
      const { error } = await service.rpc('provision_membership_record', {
        auth_user_id: userId,
        target_organization_id: organizationId,
        target_branch_id: branchId,
        target_class_id: classId,
        target_display_name: String(body.display_name ?? '').trim(),
        target_role: role,
        target_student_code: student
          ? String(body.student_code ?? '').trim()
          : null,
        internal_auth_email: student ? authEmail : null,
        provisioning_actor_id: actorData.user.id,
      });
      return error == null;
    },
    async (userId) => {
      const { error } = await service.auth.admin.deleteUser(userId);
      return error == null;
    },
  );
  if (!result.ok) {
    return new Response(JSON.stringify({ error: result.error }), {
      status: result.status,
      headers: jsonHeaders,
    });
  }

  return new Response(
    JSON.stringify({ id: result.value }),
    { status: 201, headers: jsonHeaders },
  );
});

async function revokeSessions(profileId: string): Promise<boolean> {
  const response = await fetch(
    `${Deno.env.get('SUPABASE_URL')}/auth/v1/admin/users/${profileId}/logout`,
    {
      method: 'POST',
      headers: {
        authorization: `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
        apikey: String(Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')),
      },
    },
  );
  return response.ok;
}

async function recordRevocationFailure(
  service: ReturnType<typeof serviceClient>,
  profileId: string,
  actorId: string,
  operation: string,
): Promise<void> {
  const { data: profile } = await service
    .from('profiles')
    .select('organization_id')
    .eq('id', profileId)
    .single();
  if (!profile?.organization_id) return;
  await service.rpc('record_auth_security_event', {
    event_organization_id: profile.organization_id,
    event_actor_id: actorId,
    event_subject_id: profileId,
    requested_event_type: 'session_revocation_failed',
    safe_metadata: { operation },
  });
}
