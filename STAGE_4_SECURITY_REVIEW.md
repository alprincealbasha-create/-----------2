# Stage 4 Independent Security Review

Status: **PASS**
Scope: Stage 4 diff only

## Review result

| Severity | Open |
|---|---:|
| CRITICAL | 0 |
| MAJOR | 0 |
| MODERATE | 0 |
| MINOR | 1 |

The review examined cross-tenant and cross-branch leakage, IDOR, assignment
audience exposure, duplicate obligations, lifecycle/time behavior, historical
mutability, client trust, table grants, RLS coverage, and accidental Stage 5
work.

Resolved during review:

- Added compound instance-to-assignment and instance-to-profile branch keys.
- Removed current instance access when user/class/hierarchy is inactive.
- Rejected direct assignments to inactive users.
- Rejected management through suspended organizations/branches.
- Restricted approved-library enumeration to active management roles.
- Rejected new assignments against ended/cancelled wirds.
- Converted manager-selected dates using the organization timezone on server.

## Non-blocking known finding

**MINOR — intentional backfill is manual.** A user created after an assignment
does not inherit it automatically. An authorized idempotent materialization RPC
exists, but Stage 4 does not yet provide a dedicated UI button or audit event for
that operational backfill. This does not affect initial assignment correctness,
is documented, and can be addressed with the later membership/content workflow.

No Stage 5 counter, Drift, outbox, synchronization, progress, rewards, reports,
campaigns, or exports were added.
