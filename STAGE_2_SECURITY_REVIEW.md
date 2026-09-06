# Stage 2 Security Review

Date: 2026-09-06

Review scope: Stage 2 changes only

Final result: `PASS`

## Findings

| Severity | Finding | Resolution |
|---|---|---|
| MODERATE | The first reviewed `teacher_classes` SELECT policy allowed `teacher_id = auth.uid()` without also requiring an active actor. | Fixed by coupling own-assignment access to the active-profile branch helper; clean tests rerun twice. |
| MODERATE | The first migration draft contained a redundant malformed organization unique constraint. | Removed before any final run; fresh schema creation passed twice. |
| MODERATE | One-way FKs initially allowed a trusted later workflow to change a teacher/student role while leaving its membership row orphaned, and did not enforce the reverse half of mandatory student 1:1. | Added immediate role-transition protection plus deferred end-of-transaction student-extension constraints and negative tests. |

Open `CRITICAL`: 0

Open `MAJOR`: 0

Open `MODERATE`: 0

Open `MINOR`: 0

## Review conclusions

- Authorization derives from `auth.uid()` and active server-side profile state.
- Security-definer helpers use a fixed empty search path and narrowly granted
  execution permissions.
- Composite foreign keys and validation triggers prevent privileged writers
  from constructing cross-tenant relationships.
- Direct authenticated profile mutation is denied, preventing client-side role
  or tenant escalation.
- Missing policies intentionally deny destructive entity operations.
- No service-role token or project secret exists in Flutter sources.
- The migration does not contact, reset, or overwrite a remote environment.
- No G3+ authentication or product feature was implemented.

## Residual limitations

- Full Supabase CLI/local-stack behavior is not exercised because that toolchain
  is unavailable. PostgreSQL RLS semantics and the required Supabase primitives
  are tested locally; real-session coverage remains an explicit G3 prerequisite.
- Trusted profile provisioning is intentionally absent. Stage 3/4 must provide
  a server-controlled path and must not add direct client role assignment.
- Audit-event generation and retention are deferred to their authorized gates.
