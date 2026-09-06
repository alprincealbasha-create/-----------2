# Stage 2 Migration Manifest

Status: `STAGE 2 CANONICAL MIGRATION SET`

## Ordered artifacts

| Order | Artifact | Purpose | SHA-256 |
|---|---|---|---|
| test only | `supabase/stage2/tests/000_test_bootstrap.sql` | Minimal local simulation of Supabase `auth.users`, `authenticated`, and `auth.uid()` | `A72C5F2B1A58B5748C3938FC15C74660367FB12FE225319E10F5CC02CA4F402B` |
| 1 | `supabase/stage2/migrations/202608310001_stage2_tenant_identity_foundation.sql` | Canonical G2 tables, constraints, triggers, indexes, grants, helpers, and RLS | `5E2FDACDE1C2159A215B553FD3CAB08675EF6D3540F2926D8816B1F69FC2882C` |
| test only | `supabase/stage2/tests/010_stage2_security_tests.sql` | Synthetic two-organization constraint and RLS test suite | `80FDB49B3DF7E34B29FF67573120FE6F211EB0E769AD25D31F89157D2A68D438` |

Hashes describe the reviewed Stage 2 artifacts at verification time. Any content
change requires rerunning clean application and tests and updating this record.

## Application contract

1. Apply only to a newly created, isolated development/test database whose
   emptiness and non-authoritative status are known.
2. Supabase supplies `auth.users`, `authenticated`, and `auth.uid()`; therefore
   `000_test_bootstrap.sql` is local-test infrastructure and must not be applied
   to Supabase.
3. Apply the single canonical migration in filename order.
4. Do not run the historical `supabase/migrations/20260825*.sql` set as part of
   this manifest.
5. Do not point this procedure at an existing or unknown remote project.

## Prototype transition boundary

The 18 older migration files remain unchanged as historical prototypes. Their
state is not assumed empty, compatible, or disposable. Migration of any actual
existing state requires inventory, mapping, rollback planning, and later
change-control evidence; Stage 2 performs no such transition.

## Rebuild and rollback record

The migration is forward-only and creates new objects. In an authorized,
disposable local test database, rollback is disposal of that entire explicitly
identified test database/container. There is intentionally no object-dropping
production rollback script because OD-012 prohibits destructive assumptions
about authoritative state.

Verification created separate clean databases and applied the ordered artifacts
twice. Both test runs passed and their normalized schema dumps had identical
SHA-256:

`013da997f69ca9a260c817f03f68056ea227f6a8fa46d915e69dc7a7b37321f4`

The only raw dump difference was PostgreSQL 17's random `\\restrict` token,
which has no schema meaning and was removed before comparison.
