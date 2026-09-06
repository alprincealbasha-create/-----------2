# Stage 2 Security Model

Status: `IMPLEMENTATION BASELINE`

## Trust boundary

Authorization is decided by PostgreSQL Row Level Security. Tenant IDs, branch
IDs, roles, and class membership submitted by a client are never trusted as
authorization evidence. The actor is derived from `auth.uid()` and an active
row in `profiles`.

The Flutter client receives no service-role credential. Direct profile writes
are denied to the authenticated role in Stage 2; trusted provisioning belongs
to Stage 3/4.

## Role scopes

| Role | Scope |
|---|---|
| `organization_admin` | all rows in the actor's organization |
| `branch_manager` | administrative access inside the actor's branch only |
| `admin` | administrative access inside the actor's branch only |
| `teacher` | own profile and classes/students explicitly assigned through `teacher_classes` |
| `staff` | own profile and shared branch/class directory rows only |
| `student` | own profile, own student row, own class, branch, and organization |

## Enforcement layers

1. Named checks validate roles, lifecycle states, counts, and required scope.
2. Composite foreign keys reject cross-tenant and cross-branch relationships.
3. Role-validation triggers reject student extensions for non-student profiles
   and teacher assignments for non-teacher profiles.
4. RLS filters reads and checks every permitted write.
5. Security-definer authorization helpers read only trusted database state,
   use a fixed empty search path, and are executable only by `authenticated`.
6. No authenticated delete policy exists for tenant entities; lifecycle status
   changes are the recoverable mechanism.

## Lifecycle and inactive actors

Only `profiles.status = 'active'` can authorize an operation. Suspended,
invited, and archived actors receive no tenant access through Stage 2 policies.
Target rows remain visible according to actor scope so authorized managers can
manage lifecycle state without destructive deletion.

## OD-012 isolation

Production-state absence remains unverified. Stage 2 verification therefore
uses a newly created local PostgreSQL container and synthetic identities. It
does not connect to, reset, inspect, overwrite, or infer emptiness of any
remote Supabase project.

## Deferred security work

Credential exchange, session handling, PIN lockout, provisioning RPCs,
audit-event coverage, and end-to-end Supabase Auth behavior belong to later
authorized gates. Their deferral does not weaken the tenant constraints or RLS
implemented here.
