# Stage 3 Authentication Model

Status: IMPLEMENTED — AWAITING OWNER CLOSURE

## Identity authority

Supabase Auth is the credential and session authority. Every application
identity has exactly one `profiles` row with `profiles.id = auth.users.id`.
The database, not Flutter metadata, resolves the current organization, branch,
class, role, and membership status.

## Adult flow

1. The Flutter client signs in with email and password through Supabase Auth.
2. Supabase restores and refreshes the persisted session.
3. Flutter calls `resolve_my_authorization_context()` using that session.
4. Only an active, structurally valid profile reaches a role shell. Missing,
   inactive, unknown-role, or invalid-scope profiles fail closed.
5. Logout clears Supabase tokens. Synced account-local data is removed; pending
   offline progress blocks cleanup so it is never silently discarded.

## Student flow

The approved identifier is `organization_code + student_code + 6-digit PIN`.
The public `student-login` Edge Function returns one generic failure for an
unknown organization, student, invalid PIN, inactive membership, or lock.
It resolves identity with a service-only RPC, reserves an attempt atomically,
and asks Supabase Auth to verify the PIN as that student's password. A valid
exchange returns a normal Supabase session. Flutter stores neither PIN nor a
service credential.

`student_auth_credentials` contains only server-side lookup/rate-limit metadata
and a random internal Auth email. The PIN verifier is Supabase Auth's password
hash; no plaintext PIN or readable application PIN hash exists. Five failed
attempts lock the identity for 15 minutes. A successful exchange clears the
failure state. QR is not implemented.

## Provisioning and membership lifecycle

`manage-membership` requires a real caller JWT, derives the actor with
`auth.getUser`, checks server-derived administration scope, and alone uses the
service role. Auth creation is followed by one transactional database RPC that
creates the profile, student extension, and credential metadata. A database
failure triggers deletion of the newly-created Auth identity.

Membership updates are server-controlled, preserve the organization, enforce
branch/class constraints, prevent removal of the final active organization
administrator, and request Auth session revocation. Adult-to-student or
student-to-adult category conversion is rejected; it requires explicit
deprovision/reprovision rather than silently changing a child's credential and
privacy model. PIN reset changes the Auth password, clears the lock, records a
security event, and revokes sessions.

## Trust boundaries and secrets

- Flutter contains only the public project URL and publishable/anon key.
- `SUPABASE_SERVICE_ROLE_KEY` is read only inside Edge Functions.
- Client role, organization, branch, class, and foreign IDs never authorize an
  operation by themselves.
- Stage 2 RLS remains the final operational access boundary and reads current
  profile state, so a stale token cannot preserve old operational privileges.
- Security events never contain PINs, passwords, tokens, student codes, or
  internal Auth email addresses.

## Deployment controls

`supabase/config.toml` deliberately permits unauthenticated invocation only for
`student-login`; the function itself performs credential exchange. The
membership function requires JWT verification. Deploy only to an isolated
development/test environment until production-state absence is verified.
