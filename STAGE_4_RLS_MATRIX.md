# Stage 4 RLS Matrix

Status: **VERIFIED — AWAITING OWNER CLOSURE**

| Resource | Organization admin | Branch manager/admin | Teacher/staff/student |
|---|---|---|---|
| `dhikr_definitions` | Manage/read own organization | Manage own-branch drafts; read approved own-organization content | No direct library enumeration |
| `wirds` | Manage/read own organization | Manage/read only own-branch wirds | No direct table access |
| `wird_assignments` | Read/manage own organization | Read/manage only own-branch-owned wird and branch-bounded scopes | No audience enumeration |
| `user_wird_instances` | Read own organization | Read own branch | Own current, active, hierarchy-valid instance only |
| `list_todays_wirds()` | Own current items | Own current items | Own current items only |

All four Stage 4 tables have RLS enabled. Authenticated clients receive `SELECT`
only; no direct `INSERT`, `UPDATE`, or `DELETE` grant exists. Security-definer
RPCs have fixed empty `search_path`, validate the database profile and active
hierarchy, and expose only the required operations.

Compound foreign keys bind dhikr, wird, assignment, instance, branch, class,
profile, creator, and assignment source to the same organization. Instance
source scope and wird identity are also compound-bound to the source assignment.

Anonymous callers have neither table access nor RPC execution. Suspended users,
suspended student classes, suspended branches, and suspended organizations lose
current user-facing access. Manager historical reads remain branch/tenant
bounded.
