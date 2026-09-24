# Stage 4 Security Test Report

Status: **PASS**
Date: 2026-09-24
Environment: isolated local PostgreSQL 17 container

Stage 2, Stage 3 and Stage 4 migrations were applied from zero to synthetic
database `stage4_security_review`. The Stage 4 suite then completed with
`ON_ERROR_STOP=1` and emitted `STAGE_4_SECURITY_TESTS_PASS`. No production
project, real account, or real child data was used.

| Required negative/consistency case | Result |
|---|---|
| Anonymous access | PASS |
| Organization A read/write against B | PASS |
| Branch manager sibling-branch assignment | PASS |
| Class/branch mismatch | PASS |
| Foreign-organization user target | PASS |
| Inactive direct-user target | PASS |
| Client role-claim spoofing | PASS |
| Student other-user access | PASS |
| Student assignment-audience enumeration | PASS |
| Student content mutation/direct RPC bypass | PASS |
| Teacher unrelated class/branch access | PASS |
| Invalid foreign identifiers | PASS |
| Suspended user access | PASS |
| Suspended class current access | PASS |
| Duplicate materialization/retry | PASS |
| Historical snapshot mutation/content edit | PASS |
| Future/expired/cancelled Today filtering | PASS |
| Assignment before activation | PASS |

Positive materialization was also proven for organization, branch, class, role,
and direct-user scopes. Multiple matching scopes produced one instance per
`(user_id, wird_id)`.

Test sources:

- `supabase/stage4/tests/000_test_bootstrap.sql`
- `supabase/stage4/tests/010_stage4_security_tests.sql`

The complete suite was rerun from a fresh isolated PostgreSQL 17 database for
owner closure and again emitted `STAGE_4_SECURITY_TESTS_PASS`.
