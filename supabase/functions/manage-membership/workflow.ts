export type WorkflowResult<T = void> =
  | { ok: true; value: T }
  | { ok: false; error: string; status: number };

export async function provisionWithCompensation(
  createAuthUser: () => Promise<string | null>,
  persistMembership: (userId: string) => Promise<boolean>,
  compensateAuthUser: (userId: string) => Promise<boolean>,
): Promise<WorkflowResult<string>> {
  const userId = await createAuthUser();
  if (!userId) return { ok: false, error: 'provisioning_failed', status: 409 };
  if (!await persistMembership(userId)) {
    if (!await compensateAuthUser(userId)) {
      return {
        ok: false,
        error: 'provisioning_compensation_failed',
        status: 503,
      };
    }
    return { ok: false, error: 'provisioning_failed', status: 409 };
  }
  return { ok: true, value: userId };
}

export async function changeMembershipAndRevoke(
  changeMembership: () => Promise<boolean>,
  revokeSessions: () => Promise<boolean>,
  recordRevocationFailure: () => Promise<void>,
): Promise<WorkflowResult> {
  if (!await changeMembership()) {
    return { ok: false, error: 'change_rejected', status: 409 };
  }
  let revoked = false;
  try {
    revoked = await revokeSessions();
  } catch {
    revoked = false;
  }
  if (!revoked) {
    try {
      await recordRevocationFailure();
    } catch {
      // The caller still receives a retryable failure if observability is down.
    }
    return { ok: false, error: 'session_revoke_failed', status: 503 };
  }
  return { ok: true, value: undefined };
}

export async function resetPinAndRevoke(
  updatePassword: () => Promise<boolean>,
  recordReset: () => Promise<boolean>,
  revokeSessions: () => Promise<boolean>,
  recordRevocationFailure: () => Promise<void>,
): Promise<WorkflowResult> {
  if (!await updatePassword() || !await recordReset()) {
    return { ok: false, error: 'reset_failed', status: 409 };
  }
  let revoked = false;
  try {
    revoked = await revokeSessions();
  } catch {
    revoked = false;
  }
  if (!revoked) {
    try {
      await recordRevocationFailure();
    } catch {
      // The caller still receives a retryable failure if observability is down.
    }
    return { ok: false, error: 'session_revoke_failed', status: 503 };
  }
  return { ok: true, value: undefined };
}
