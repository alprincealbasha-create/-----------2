# Stage 2 Database Test Report

Date: 2026-09-06

Result: `PASS`

## Environment

- Engine: PostgreSQL 17.11 (`postgres:17-alpine`)
- Runtime: rootless Podman 5.8.6 inside the local WSL environment
- Container: `rawdat-wird-stage2-pg`, labeled `rawdat-wird.stage=2`
- Data: synthetic only
- Remote connections: none
- Supabase CLI: unavailable on this workstation

The local bootstrap reproduces only the Supabase database primitives needed by
this gate: `auth.users`, role `authenticated`, and `auth.uid()` derived from the
JWT subject setting. It does not claim to test Stage 3 authentication flows.

## Executions

| Run | Starting state | Migration | Constraint/RLS suite | Result |
|---|---|---|---|---|
| initial validation | new isolated database | applied | executed | PASS after migration authoring corrections |
| deterministic clean run 1 | new database `rawdat_wird_stage2_clean_6` | applied once | `STAGE_2_DATABASE_TESTS_PASS` | PASS |
| deterministic clean run 2 | new database `rawdat_wird_stage2_clean_7` | applied once | `STAGE_2_DATABASE_TESTS_PASS` | PASS |
| final expanded security run 1 | new database `rawdat_wird_stage2_clean_8` | applied once | `STAGE_2_DATABASE_TESTS_PASS` | PASS |
| final expanded security run 2 | new database `rawdat_wird_stage2_clean_9` | applied once | `STAGE_2_DATABASE_TESTS_PASS` | PASS |

Normalized schema hashes for deterministic clean runs 1 and 2 were identical:
`013da997f69ca9a260c817f03f68056ea227f6a8fa46d915e69dc7a7b37321f4`.

The migration did not change between those deterministic runs and the final
expanded runs. The final test-only artifact added one negative assertion for
deleting a mandatory student extension; both expanded runs passed. A later
attempt to re-dump runs 8 and 9 was not used as evidence because the WSL
Podman run directory had become inaccessible.

## Coverage

Passed checks include:

- RLS enabled on all six canonical Stage 2 tables;
- the expected 15 policies exist;
- globally normalized organization code uniqueness;
- normalized branch, class/year, and student-code uniqueness;
- valid IANA organization timezone;
- mandatory role/branch scope;
- employee organization/branch consistency;
- student profile/class organization and branch consistency;
- student-profile role validation;
- mandatory 1:1 student extension at transaction completion;
- teacher role and same-branch class assignment validation;
- prevention of orphaned student extensions and teacher assignments on role change;
- organization-admin isolation from another organization;
- Damascus manager isolation from Aleppo and organization 2;
- teacher access only to assigned class and linked child;
- student access only to self and own hierarchy;
- staff denial from child data by default;
- invited/inactive actor denial;
- authenticated denial of profile role mutation;
- recoverable lifecycle policy: no tenant-entity deletes;
- authorized and unauthorized teacher-class deletion behavior;
- SELECT, INSERT, UPDATE, and DELETE RLS paths.

## Failures during authoring

Three issues were found before the final clean runs: a malformed redundant
unique constraint, an inactive-teacher visibility gap, and missing reverse
enforcement against orphaned role memberships. All were corrected. The final
migration passed two fresh applications; no test is skipped or weakened.

## Result boundary

This is database/RLS evidence, not proof of Supabase Auth sessions, PIN login,
client provisioning, or deployment to a real project. Those remain outside G2.
