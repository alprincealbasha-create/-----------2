# Stage 4 Assignment Model

Status: **IMPLEMENTED — AWAITING OWNER CLOSURE**

## Atomic scopes

`wird_assignments` supports exactly five server values:

| Scope | Required target | Audience |
|---|---|---|
| `organization` | none | Every active member in the organization |
| `branch` | `branch_id` | Every active member in that active branch |
| `class` | `branch_id`, `class_id` | Active students in that active class |
| `role` | `role`; optional branch boundary | Active members with the role |
| `user` | `user_id`; matching branch snapshot where applicable | One active member |

Several branches are represented by several atomic `branch` rows. The client
never stores a comma-separated list and the database has no
`multiple_branches` scope.

## Authorization and validation

Organization administrators may create any scope in their organization.
Branch managers and branch administrators may create only branch-bounded
scopes inside their own active branch. Server functions resolve the caller from
`auth.uid()` and verify tenant, branch, class, role, user, hierarchy lifecycle,
and source-wird ownership. JWT role/tenant claims are not authorization input.

The client has table `SELECT` only. All mutations use guarded RPCs. The atomic
`create_wird_with_assignments` RPC creates the scheduled wird and all requested
scope rows in one transaction.

## Materialization and idempotency

Each accepted scope materializes eligible active profiles immediately, including
before activation. The unique business key is:

`UNIQUE(user_id, wird_id)`

`INSERT ... ON CONFLICT DO NOTHING` makes overlapping scopes and explicit
retries idempotent. The first successfully materialized matching scope is the
preserved assignment source; later overlap does not rewrite it.

Users added after assignment creation are not silently inherited. An authorized
manager may explicitly call the idempotent materialization RPC while the
assignment remains active. This keeps backfill intentional and auditable.

Revocation changes the assignment to `revoked` and records `revoked_at`; it does
not delete or mutate historical instances.
