import {
  handleStudentLogin,
  type StudentCandidate,
  type StudentLoginDependencies,
} from '../../functions/student-login/handler.ts';
import {
  changeMembershipAndRevoke,
  provisionWithCompensation,
  resetPinAndRevoke,
} from '../../functions/manage-membership/workflow.ts';

export type EdgeTestCase = { name: string; run: () => Promise<void> };
export const edgeTests: EdgeTestCase[] = [];

function edgeTest(name: string, run: () => Promise<void>): void {
  edgeTests.push({ name, run });
}

function assert(condition: unknown, message: string): asserts condition {
  if (!condition) throw new Error(`ASSERTION FAILED: ${message}`);
}

const candidate: StudentCandidate = {
  profileId: 'student-profile',
  organizationId: 'organization-one',
  authEmail: 'random-internal@auth.invalid',
};

function loginDependencies(
  overrides: Partial<StudentLoginDependencies> = {},
): StudentLoginDependencies {
  return {
    reserve: async () => candidate,
    verify: async () => ({
      userId: candidate.profileId,
      accessToken: 'synthetic-access',
      refreshToken: 'synthetic-refresh',
      expiresAt: 123,
      tokenType: 'bearer',
    }),
    complete: async () => true,
    recordFailure: async () => {},
    burnDummyAttempt: async () => {},
    ...overrides,
  };
}

function loginRequest(body: Record<string, unknown>): Request {
  return new Request('http://edge.test/student-login', {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify(body),
  });
}

edgeTest('student login returns a normal session after trusted verification', async () => {
  const response = await handleStudentLogin(loginRequest({
    organization_code: 'RW-ONE',
    student_code: 'ST-001',
    pin: '123456',
  }), loginDependencies());
  const body = await response.json();
  assert(response.status === 200, 'valid login must succeed');
  assert(body.refresh_token === 'synthetic-refresh', 'normal session must be returned');
});

edgeTest('unknown student burns dummy work and returns generic failure', async () => {
  let dummyBurned = false;
  const response = await handleStudentLogin(loginRequest({
    organization_code: 'UNKNOWN',
    student_code: 'UNKNOWN',
    pin: '123456',
  }), loginDependencies({
    reserve: async () => null,
    burnDummyAttempt: async () => {
      dummyBurned = true;
    },
  }));
  const body = await response.json();
  assert(response.status === 401, 'unknown identity must fail');
  assert(body.error === 'invalid_credentials', 'failure must be generic');
  assert(dummyBurned, 'unknown identity must perform dummy verification work');
});

edgeTest('wrong PIN and identity mismatch are generic and audited', async () => {
  let failureRecorded = false;
  const response = await handleStudentLogin(loginRequest({
    organization_code: 'RW-ONE',
    student_code: 'ST-001',
    pin: '654321',
  }), loginDependencies({
    verify: async () => null,
    recordFailure: async () => {
      failureRecorded = true;
    },
  }));
  assert(response.status === 401, 'bad PIN must fail');
  assert(failureRecorded, 'failed verification must be recorded');
});

edgeTest('invalid PIN format never reaches identity lookup', async () => {
  let reserved = false;
  const response = await handleStudentLogin(loginRequest({
    organization_code: 'RW-ONE',
    student_code: 'ST-001',
    pin: '1234',
  }), loginDependencies({
    reserve: async () => {
      reserved = true;
      return candidate;
    },
  }));
  assert(response.status === 401, 'invalid PIN format must fail generically');
  assert(!reserved, 'invalid input must not query identity data');
});

edgeTest('completion failure never releases session tokens', async () => {
  const response = await handleStudentLogin(loginRequest({
    organization_code: 'RW-ONE',
    student_code: 'ST-001',
    pin: '123456',
  }), loginDependencies({ complete: async () => false }));
  assert(response.status === 503, 'incomplete server state must fail closed');
  assert(!(await response.text()).includes('synthetic-refresh'), 'tokens must not leak');
});

edgeTest('provisioning compensates Auth identity when membership persistence fails', async () => {
  let deleted = false;
  const result = await provisionWithCompensation(
    async () => 'new-user',
    async () => false,
    async (id) => {
      deleted = id === 'new-user';
      return deleted;
    },
  );
  assert(!result.ok && result.error === 'provisioning_failed', 'workflow must fail');
  assert(deleted, 'orphan Auth user must be deleted');
});

edgeTest('provisioning exposes a failed Auth compensation for retry', async () => {
  const result = await provisionWithCompensation(
    async () => 'new-user',
    async () => false,
    async () => false,
  );
  assert(
    !result.ok && result.error === 'provisioning_compensation_failed' &&
      result.status === 503,
    'failed compensation must be explicit and retryable',
  );
});

edgeTest('membership change requires successful session revocation', async () => {
  let failureRecorded = false;
  const result = await changeMembershipAndRevoke(
    async () => true,
    async () => false,
    async () => {
      failureRecorded = true;
    },
  );
  assert(!result.ok && result.status === 503, 'revocation failure must be visible');
  assert(failureRecorded, 'revocation failure must be recorded');
});

edgeTest('membership change fails closed when revocation throws', async () => {
  let failureRecorded = false;
  const result = await changeMembershipAndRevoke(
    async () => true,
    async () => {
      throw new Error('synthetic Auth outage');
    },
    async () => {
      failureRecorded = true;
    },
  );
  assert(!result.ok && result.status === 503, 'Auth outage must be retryable');
  assert(failureRecorded, 'Auth outage must be recorded');
});

edgeTest('PIN reset requires password, audit state, and revocation', async () => {
  let revocationFailureRecorded = false;
  const success = await resetPinAndRevoke(
    async () => true,
    async () => true,
    async () => true,
    async () => {},
  );
  const failure = await resetPinAndRevoke(
    async () => true,
    async () => false,
    async () => true,
    async () => {},
  );
  const revokeFailure = await resetPinAndRevoke(
    async () => true,
    async () => true,
    async () => false,
    async () => {
      revocationFailureRecorded = true;
    },
  );
  assert(success.ok, 'complete reset workflow must succeed');
  assert(!failure.ok && failure.error === 'reset_failed', 'missing audit state must fail');
  assert(
    !revokeFailure.ok && revokeFailure.error === 'session_revoke_failed',
    'revocation failure must be visible',
  );
  assert(revocationFailureRecorded, 'PIN reset revocation failure must be recorded');
});
