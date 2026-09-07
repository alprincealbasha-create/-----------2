# Stage 3 Role Access Matrix

Status: IMPLEMENTED — AWAITING OWNER CLOSURE

| Role | Required scope | Stage 3 shell | Provision/manage users | Backend boundary |
|---|---|---|---|---|
| `organization_admin` | organization; branch must be null | Organization administration | All permitted roles inside own organization; cannot remove final active org admin | Own organization only |
| `branch_manager` | organization + branch | Branch manager | `admin`, `teacher`, `staff`, `student` in own branch; cannot manage higher roles | Own branch only |
| `admin` | organization + branch | Operational administration | `teacher`, `staff`, `student` in own branch | Own branch; no security-wide access |
| `teacher` | organization + branch; class grants separate | Teacher | None | Self plus authorized classes/students |
| `staff` | organization + branch | Staff | None | Self and permitted branch resources; no student records by default |
| `student` | organization + branch + class | Student | None | Own profile/student record and own hierarchy only |

The six Flutter routes are UX shells only. Every shell destination is derived
from the authorization context returned for `auth.uid()`. Direct REST/RPC calls
remain governed by RLS and service-only function grants.

## Lifecycle rules

- `active`: may resolve a usable application context.
- `invited`, `suspended`, or `archived`: fail closed in Flutter; Stage 2 RLS
  denies operational access immediately.
- Role or branch change: must pass both old-target and desired-scope server
  authorization and triggers session revocation.
- Student class/branch change: updated atomically and checked by tenant FKs.
- Cross-organization membership moves: not supported in MVP.
