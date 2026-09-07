export type StudentCandidate = {
  profileId: string;
  organizationId: string;
  authEmail: string;
};

export type VerifiedStudentSession = {
  userId: string;
  accessToken: string;
  refreshToken: string;
  expiresAt: number | null;
  tokenType: string;
};

export type StudentLoginDependencies = {
  reserve(organizationCode: string, studentCode: string): Promise<StudentCandidate | null>;
  verify(authEmail: string, pin: string): Promise<VerifiedStudentSession | null>;
  complete(profileId: string): Promise<boolean>;
  recordFailure(candidate: StudentCandidate): Promise<void>;
  burnDummyAttempt(pin: string): Promise<void>;
};

const headers = {
  'content-type': 'application/json; charset=utf-8',
  'cache-control': 'no-store',
};

const failure = () => new Response(
  JSON.stringify({ error: 'invalid_credentials' }),
  { status: 401, headers },
);

export async function handleStudentLogin(
  request: Request,
  dependencies: StudentLoginDependencies,
): Promise<Response> {
  if (request.method !== 'POST') {
    return new Response(null, { status: 405, headers });
  }

  let body: Record<string, unknown>;
  try {
    body = await request.json();
  } catch {
    return failure();
  }

  const organizationCode = String(body.organization_code ?? '').trim();
  const studentCode = String(body.student_code ?? '').trim();
  const pin = String(body.pin ?? '');
  if (
    organizationCode.length < 1 || organizationCode.length > 64 ||
    studentCode.length < 1 || studentCode.length > 64 ||
    !/^\d{6}$/.test(pin)
  ) return failure();

  const candidate = await dependencies.reserve(organizationCode, studentCode);
  if (!candidate) {
    await dependencies.burnDummyAttempt(pin);
    return failure();
  }

  const session = await dependencies.verify(candidate.authEmail, pin);
  if (!session || session.userId !== candidate.profileId) {
    await dependencies.recordFailure(candidate);
    return failure();
  }

  if (!await dependencies.complete(candidate.profileId)) {
    return new Response(JSON.stringify({ error: 'service_unavailable' }), {
      status: 503,
      headers,
    });
  }

  return new Response(JSON.stringify({
    access_token: session.accessToken,
    refresh_token: session.refreshToken,
    expires_at: session.expiresAt,
    token_type: session.tokenType,
  }), { status: 200, headers });
}
