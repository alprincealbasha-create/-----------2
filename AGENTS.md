# Project Rules — Rawdat Wird

## Product

Rawdat Wird is a multi-branch Flutter application for tracking
assigned Islamic adhkar/wird completion across kindergarten branches.

The system supports children, teachers, staff, branch managers,
and organization administrators.

Read PRODUCT_REQUIREMENTS.md and DATABASE_SCHEMA.md before implementing
any feature.

Read CODEX_PLAN.md and obey its current gate. Never implement work from a
future gate. When the current gate is G0, do not write application code,
database migrations, or release artifacts.

The owner-approved G0 baselines are `MVP_SCOPE_BASELINE.md`,
`ROLE_AND_SCOPE_MODEL.md`, `STUDENT_AUTH_POLICY.md`,
`LOGICAL_DATA_MODEL.md`, `OFFLINE_SYNC_CONTRACT.md`,
`PLATFORM_BASELINE.md`, and `GATE_ACCEPTANCE_MATRIX.md`. When legacy
prototype text conflicts with them, follow the approved baselines and the
document precedence in `DOCUMENT_AUTHORITY_MAP.md`.

Production-state absence is NOT VERIFIED. Never delete, reset, overwrite, or
assume an existing database is empty. Isolated local/test environments and
synthetic data are allowed only in the gate that authorizes them and only
when potentially authoritative state cannot be affected.

G0 is frozen by owner decision `GD-G0-FINAL`. Read
`G0_FROZEN_BASELINE.md` before G1 work. Do not silently edit a frozen G0
baseline. A substantive change requires a recorded change ID, owner approval,
affected documents/gates, downstream impact, and an updated baseline version.
G1, G2, G3, and G4 are approved and closed. Stage 4 was closed by the owner
after its final verification. G5-G12 are not open.

---

## Architecture

Use Flutter.

Use feature-first architecture with pragmatic Clean Architecture.

Do not introduce unnecessary abstraction.

Target project structure:

```text
rawdat_wird/
├── AGENTS.md
├── README.md
├── PRODUCT_REQUIREMENTS.md
├── DATABASE_SCHEMA.md
├── supabase/
│   ├── migrations/
│   ├── seed.sql
│   └── tests/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── config/
│   │   ├── database/
│   │   ├── errors/
│   │   ├── network/
│   │   ├── routing/
│   │   └── security/
│   ├── shared/
│   │   ├── models/
│   │   └── widgets/
│   └── features/
│       ├── auth/
│       ├── organizations/
│       ├── branches/
│       ├── classes/
│       ├── users/
│       ├── adhkar/
│       ├── wirds/
│       ├── counter/
│       ├── progress/
│       ├── rewards/
│       ├── campaigns/
│       ├── dashboard/
│       └── reports/
└── test/
```

Treat this as an approximate target, not a reason for a large unrelated
refactor. Do not create empty directories only to mirror the tree. Place new
work in the correct location and move existing code incrementally only when
the affected feature is being changed and its tests remain green.

Each feature may contain:

```text
data/
domain/
presentation/
```

Only create layers that provide real value.

---

## State Management

Use Riverpod.

Do not mix multiple state-management frameworks.

---

## Navigation

Use go_router.

Navigation access must respect user roles.

Do not rely on navigation guards as the only security mechanism.

---

## Backend

Use Supabase.

Use PostgreSQL relational modeling.

Use Supabase Auth where appropriate.

All sensitive data access must be protected using Row Level Security.

Never trust role information provided only by the client.

---

## Multi-Tenancy

Every operational record must belong to an organization.

Users belonging to a branch must be scoped to that branch.

Students must always have:

```text
organization_id
branch_id
class_id
```

Branch staff must always have:

```text
organization_id
branch_id
```

Organization-level administrators may have branch_id = null.

Never allow branch managers to access another branch.

---

## Children

Collect only the minimum data required.

Do not add:

```text
location tracking
advertising identifiers
unnecessary personal data
child photos
```

unless explicitly requested in the product requirements.

---

## Dhikr Counter

Counter interactions must feel immediate.

Never make one synchronous network request per button tap.

Counter changes must be saved locally first.

Progress must survive:

```text
app restart
network loss
device reconnection
```

Use a reliable local persistence strategy.

Implement idempotent synchronization.

Never lose valid locally recorded progress.

Never double-count the same sync event.

---

## Offline First

The Dhikr counter is offline-first.

Network connectivity must not be required to perform dhikr counting.

Synchronize when connectivity is available.

Design for intermittent and unreliable mobile connectivity.

---

## Progress

Do not store every button tap as the primary server-side progress model.

Maintain aggregated progress.

If synchronization events are used, ensure they are idempotent.

---

## Points

Do not calculate rewards using raw tap count alone.

Rewards must primarily reflect completion and consistency.

Use a points ledger rather than only storing a mutable total.

---

## Security

Apply least privilege.

Use database-level authorization.

Create and test RLS policies.

Never expose service-role credentials in the Flutter client.

Never commit secrets.

Use environment variables for configuration.

---

## Code Quality

Keep functions small and understandable.

Prefer explicit code over clever abstractions.

Avoid duplicated business rules.

Never perform unrelated refactors while implementing a feature.

Do not add a package unless it has a clear justification.

---

## Testing

Every critical domain rule must have tests.

At minimum test:

```text
role authorization logic
counter persistence
offline progress
sync idempotency
wird completion
points calculation
```

Run:

```text
flutter analyze
flutter test
```

before declaring a task complete.

---

## Database Changes

Database changes must use migrations.

Never modify production schemas manually.

Keep migrations deterministic and version-controlled.

---

## Definition of Done

A feature is complete only when:

1. Implementation is finished.
2. Relevant tests exist.
3. Tests pass.
4. flutter analyze passes.
5. Offline behavior was considered.
6. Authorization was considered.
7. No unrelated files were modified.
8. Documentation was updated when necessary.

---

## Important

Do not implement future features unless explicitly requested.

Do not expand the project into a full kindergarten management system.

The MVP focuses on:

```text
organizations
branches
classes
users
adhkar
wirds
counter
progress
basic rewards
basic reporting
```
