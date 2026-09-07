# Stage 3 Security Test Report

Status: `PASS`

## Live PostgreSQL/RLS

A new synthetic database, `stage3_final_20260907c`, was created inside the
isolated `rawdat-wird-stage3-pg` PostgreSQL 17 container. Stage 2 bootstrap and
migration, Stage 3 bootstrap and migration, and both security suites were
applied from zero with stop-on-error enabled.

Results:

- `STAGE_2_DATABASE_TESTS_PASS`
- `STAGE_3_AUTH_SECURITY_TESTS_PASS`

Verified cases include unauthenticated denial, inactive-member denial,
organization isolation, branch isolation, teacher-class isolation, staff
restrictions, student self-isolation, role/tenant/branch spoofing, direct SQL/API
equivalent bypass attempts, stale JWT/current-state enforcement, credential
table secrecy, five-attempt lockout, provisioning invariants, and durable
revocation-failure logging.

## Edge Functions

The official Supabase Edge Runtime image `v1.74.3` compiled and ran the actual
student-login handler and membership workflow modules. A local HTTP call to the
runtime returned:

`STAGE_3_EDGE_FUNCTION_TESTS_PASS count=10`

Positive and negative coverage:

- successful trusted student exchange returns a normal session shape
- unknown student performs dummy work and receives a generic failure
- wrong PIN is generic and audited
- malformed PIN never reaches identity lookup
- incomplete login finalization never releases tokens
- provisioning persistence failure compensates the Auth identity
- compensation failure is explicit and retryable
- membership change requires successful session revocation
- thrown revocation outage fails closed and is recorded
- PIN reset requires password update, database audit state, and revocation

The production Edge entry files also passed TypeScript syntax checks. External
Supabase calls used synthetic adapters; the remaining full-GoTrue deployment
smoke is recorded as a non-blocking minor verification item.

## Flutter regression

- `flutter analyze`: PASS, no issues.
- `flutter test`: PASS, 68 tests.

## Data safety

Only synthetic data and isolated local containers were used. No production or
unknown authoritative state was accessed or modified.
