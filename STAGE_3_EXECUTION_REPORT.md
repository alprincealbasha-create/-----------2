# STAGE_3_EXECUTION_REPORT

Status: `PASS — STAGE 3 READY FOR OWNER CLOSURE`

## 1. AUTHORITATIVE MODEL

Stage 3 implements the six approved roles on the Stage 2 tenant hierarchy.
Supabase Auth is the identity authority, `profiles.id = auth.users.id`, and the
database resolves organization, branch, class, role, and status for
`auth.uid()`. No client-provided role or tenant value is trusted.

## 2. AUTHENTICATION ARCHITECTURE

Adults use Supabase password authentication. Students submit organization
code, student code, and a six-digit PIN to a credential Edge Function. Both
paths resolve a fresh database authorization context before application access.

## 3. STUDENT LOGIN IMPLEMENTATION

Student identity lookup is service-only; identifiers are normalized; errors
are generic; unknown identities perform dummy verification work; five attempts
lock the identity for 15 minutes; and PIN verification remains in Supabase
Auth. No PIN is stored in Flutter or application tables. QR login is outside
the approved Stage 3 scope.

## 4. ADULT LOGIN IMPLEMENTATION

Email/password login, persisted-session restoration, auth-state listening,
safe failures, inactive-context rejection, and logout are implemented.

## 5. PROVISIONING AND MEMBERSHIP

The authenticated membership Edge Function resolves the actor server-side,
performs scoped authorization, creates the Auth identity, and calls
transactional database RPCs. Failed persistence compensates by deleting the
new Auth identity. Failed compensation is now explicit and retryable rather
than silently ignored.

## 6. SESSION LIFECYCLE

RLS reads current membership state, so a suspended or moved account loses its
old data scope even if it still holds an older JWT. Membership and PIN changes
request global Auth revocation. A revocation failure returns `503` and writes a
tenant-scoped `session_revocation_failed` security event for operational retry.

## 7. ROLE ACCESS MATRIX

The six roles and their minimal route shells are documented in
`STAGE_3_ROLE_ACCESS_MATRIX.md`. No Stage 4 feature screen was opened.

## 8. ENVIRONMENT REMEDIATION

The original WSL error was caused by starting the Podman distribution outside
Podman's managed rootless session. That session lacked the prepared
`/run/user/1000` runtime state and socket. Starting
`podman-machine-default` through Podman restored the rootless socket and
container run root. An isolated PostgreSQL 17 container and the official
Supabase Edge Runtime `v1.74.3` were then used with synthetic data only.

## 9. LIVE SECURITY VERIFICATION

- Fresh Stage 2 migration and regression suite: `STAGE_2_DATABASE_TESTS_PASS`.
- Fresh Stage 3 migration and RLS suite: `STAGE_3_AUTH_SECURITY_TESTS_PASS`.
- Official Edge Runtime execution: `STAGE_3_EDGE_FUNCTION_TESTS_PASS count=10`.
- The Edge HTTP harness returned the same marker and ten passed cases.

The SQL suite covers anonymous access, inactive users, organization and branch
isolation, teacher class boundaries, staff restrictions, student self-access,
role/tenant/branch spoofing, direct API attempts, stale-session behavior,
student lockout, provisioning, and membership integrity.

## 10. FLUTTER AND ANDROID

`flutter analyze` passed with no issues and `flutter test` passed all 68 tests.
The existing Android 16 / API 36 build, install, launch, and login UI smoke
evidence remains valid. This remediation changed only backend/test artifacts,
so a second Android application smoke run was not required. A final device
availability probe found the local emulator offline after its relaunch exited;
this did not affect any changed code or the retained Stage 3 Android evidence.

## 11. INDEPENDENT SECURITY REVIEW

`CRITICAL = 0`, `MAJOR = 0`, `MODERATE = 0`, `MINOR = 2`.

The former moderate revocation-observability gap is closed by durable security
event recording plus retryable failure semantics. Remaining minor items are
documented in `STAGE_3_SECURITY_REVIEW.md`.

## 12. SECRETS AND DATA SAFETY

No service-role value, password, PIN, access token, refresh token, signing key,
real child data, or machine-specific absolute path is present in the Stage 3
source changes. Only isolated databases and synthetic identities were used.
Production-state absence remains unverified and no production state was read,
reset, overwritten, or assumed empty.

## 13. CHANGED FILES

The uncommitted diff is limited to Stage 3 authentication/domain/routing work,
account-local logout isolation, their Flutter tests, the additive Stage 3 SQL
migration and security tests, Edge Functions and runtime harness, and Stage 3
evidence documents/screenshots. No Stage 4 implementation is present.

## 14. GIT STATUS

HEAD remains the approved Stage 2 baseline
`6f76b63a2ff7a804db29634150e99827a294aefb`. Stage 3 changes remain
intentionally uncommitted. No closure commit was created.

## 15. STAGE 3 ACCEPTANCE MATRIX

| Criterion | Result |
|---|---|
| Adult authentication and session lifecycle | PASS |
| Approved student PIN exchange design and handler | PASS |
| Trusted database role/scope resolution | PASS |
| Six roles and route isolation | PASS |
| Organization, branch, class, and student RLS isolation | PASS — live PostgreSQL |
| Inactive and stale-session access removal | PASS — live PostgreSQL |
| Role, tenant, and branch spoof resistance | PASS — live PostgreSQL |
| Service-only provisioning and compensation | PASS — Edge Runtime tests |
| PIN lockout and reset workflows | PASS — live SQL and Edge Runtime tests |
| Revocation failure visibility | PASS — retryable 503 plus durable event |
| Flutter analyzer and automated tests | PASS — 0 issues / 68 tests |
| Android evidence for affected Flutter code | PASS — retained; no Flutter remediation change |
| Secrets and synthetic-data requirement | PASS |
| CRITICAL / MAJOR / MODERATE findings | PASS — 0 / 0 / 0 |
| Stage 4 untouched | PASS |

## 16. FINAL RECOMMENDATION

`PASS — STAGE 3 READY FOR OWNER CLOSURE`

`STAGE 3 VERIFIED — AWAITING OWNER CLOSURE`
