# Stage 2 RLS Matrix

`Self` means `auth.uid()` matches the target identity. `Org` and `Br` are read
from the actor's active server-side `profiles` row, never from a client claim.
`TC` means an explicit same-tenant row in `teacher_classes`. Absence of a policy
is an intentional denial.

| Table | Actor | SELECT | INSERT | UPDATE | DELETE | Scope rule |
|---|---|---|---|---|---|---|
| `organizations` | organization_admin | allow | deny | allow | deny | actor active; target `id = Org` |
| `organizations` | branch_manager / admin / teacher / staff / student | allow | deny | deny | deny | actor active; target `id = Org` |
| `branches` | organization_admin | allow | allow | allow | deny | target `organization_id = Org` |
| `branches` | branch_manager / admin | allow | deny | allow | deny | target organization and `id = Br` |
| `branches` | teacher / staff / student | allow | deny | deny | deny | target organization and `id = Br` |
| `classes` | organization_admin | allow | allow | allow | deny | target `organization_id = Org` |
| `classes` | branch_manager / admin | allow | allow | allow | deny | target organization and `branch_id = Br` |
| `classes` | teacher | allow | deny | deny | deny | active actor and matching `TC` assignment |
| `classes` | staff | allow | deny | deny | deny | target organization and `branch_id = Br` |
| `classes` | student | allow | deny | deny | deny | class is referenced by actor's student row |
| `profiles` | organization_admin | allow | deny | deny | deny | target `organization_id = Org` |
| `profiles` | branch_manager / admin | allow | deny | deny | deny | target organization and `branch_id = Br` |
| `profiles` | teacher | allow | deny | deny | deny | `Self`, or student profile linked through `TC` |
| `profiles` | staff / student | allow | deny | deny | deny | `Self` only |
| `students` | organization_admin | allow | allow | allow | deny | target `organization_id = Org` |
| `students` | branch_manager / admin | allow | allow | allow | deny | target organization and `branch_id = Br` |
| `students` | teacher | allow | deny | deny | deny | target class has matching `TC` assignment |
| `students` | student | allow | deny | deny | deny | target `profile_id = Self` |
| `students` | staff | deny | deny | deny | deny | least privilege; no child record access by default |
| `teacher_classes` | organization_admin | allow | allow | deny | allow | target `organization_id = Org` |
| `teacher_classes` | branch_manager / admin | allow | allow | deny | allow | target organization and `branch_id = Br` |
| `teacher_classes` | teacher | allow | deny | deny | deny | active actor and target `teacher_id = Self` |
| `teacher_classes` | staff / student | deny | deny | deny | deny | no authorized relationship |

## Implementation notes

- Authenticated identity comes exclusively from `auth.uid()`.
- Organization membership, role, lifecycle status, and branch scope come from
  `profiles` through fixed-search-path security-definer helpers.
- Composite foreign keys remain authoritative even after an RLS check passes.
- Profile writes have no authenticated policy because a trusted provisioning
  mechanism is a later-gate responsibility.
- Table grants make the API surface available; RLS is the mandatory row-level
  authorization layer. Service-role credentials are not used by the client.
