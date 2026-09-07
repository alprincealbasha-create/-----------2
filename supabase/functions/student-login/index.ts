import { publicClient, serviceClient } from '../_shared/clients.ts';
import { handleStudentLogin } from './handler.ts';

Deno.serve((request) => handleStudentLogin(request, {
  async reserve(organizationCode, studentCode) {
    const service = serviceClient();
    const { data: candidates, error: lookupError } = await service.rpc(
      'begin_student_login', {
        requested_organization_code: organizationCode,
        requested_student_code: studentCode,
      });

    if (lookupError || !Array.isArray(candidates) || candidates.length !== 1) {
      return null;
    }
    const candidate = candidates[0] as {
      profile_id: string;
      organization_id: string;
      auth_email: string;
    };
    return {
      profileId: candidate.profile_id,
      organizationId: candidate.organization_id,
      authEmail: candidate.auth_email,
    };
  },
  async verify(authEmail, pin) {
    const { data, error } = await publicClient().auth.signInWithPassword({
      email: authEmail,
      password: pin,
    });
    if (error || !data.session || !data.user) return null;
    return {
      userId: data.user.id,
      accessToken: data.session.access_token,
      refreshToken: data.session.refresh_token,
      expiresAt: data.session.expires_at ?? null,
      tokenType: data.session.token_type,
    };
  },
  async recordFailure(candidate) {
    await serviceClient().rpc('record_auth_security_event', {
      event_organization_id: candidate.organizationId,
      event_actor_id: null,
      event_subject_id: candidate.profileId,
      requested_event_type: 'student_login_failed',
      safe_metadata: {},
    });
  },
  async complete(profileId) {
    const { error } = await serviceClient().rpc(
      'complete_student_login',
      { login_profile_id: profileId },
    );
    return error == null;
  },
  async burnDummyAttempt(pin) {
    await publicClient().auth.signInWithPassword({
      email: `missing-${crypto.randomUUID()}@invalid.local`,
      password: pin,
    });
  },
}));
