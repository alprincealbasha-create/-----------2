# Stage 2 Verification

Date: 2026-09-06

State: `STAGE 2 = CLOSED / APPROVED`

## Baseline

- Starting commit: `36c4cdca14e8a2424f14629a47074cc531504341`
- Starting working tree: clean
- G0: approved / closed / frozen
- G1: approved / closed
- G2: opened by explicit owner authorization
- G3-G12: not opened
- OD-012: active throughout verification

## Acceptance evidence

| Criterion | Result | Evidence |
|---|---|---|
| Authoritative hierarchy and identity implemented | PASS | data-model review and canonical migration |
| Deterministic migration | PASS | two clean applications; matching normalized schema hash |
| Two organizations and multiple branches | PASS | synthetic SQL fixture |
| Student/employee tenant mismatch rejected | PASS | negative constraint tests |
| Branch manager cannot access sibling branch | PASS | Damascus/Aleppo RLS tests |
| Organization isolation | PASS | organization-admin and cross-org tests |
| Teacher limited to authorized classes | PASS | teacher assignment tests |
| Student limited to own data | PASS | student-session tests |
| SELECT/INSERT/UPDATE/DELETE covered | PASS | RLS suite |
| No parallel canonical legacy model | PASS | Stage 2 manifest isolates prototype files |
| No service role in Flutter client | PASS | source scan returned no matches |
| Production/unknown state untouched | PASS | local labeled container and synthetic databases only |
| No future-gate feature implemented | PASS | scope and Git diff review |
| Flutter static regression | PASS | `flutter analyze`: no issues found |
| Existing Flutter tests | PASS | `flutter test`: 63 tests passed |

## Toolchain qualification

Supabase CLI and Docker were unavailable. A rootless Podman PostgreSQL 17
container was available and contained no pre-existing containers. It was used
as a new isolated test target. The Supabase-specific database primitives needed
by the policies were provided by the test-only bootstrap; no acceptance rule
was removed.

Flutter's analysis server initially failed while decoding the Arabic workspace
path. Re-running analyze and tests through a temporary Latin drive alias to the
same directory succeeded; the alias was removed immediately. No source
workaround was added.

After all final database runs passed, a later Podman inspection could not
reattach to its WSL run directory because `/run/user/1000` was not writable.
No empty hash from that failed inspection is treated as evidence. The retained
determinism evidence comes from clean runs 6 and 7; the final expanded security
suite independently passed on clean runs 8 and 9. Container stop state after
the latter runs is therefore not verified and should be checked when that WSL
runtime is next available.

## Owner closure

On 2026-09-06 the owner issued `APPROVE — CLOSE STAGE 2` and accepted the
`STAGE_2_EXECUTION_REPORT` result `PASS — STAGE 2 READY FOR OWNER CLOSURE`.

## NON-BLOCKING ENVIRONMENTAL NOTE

The Podman/WSL run-directory reattachment issue is retained as environmental
evidence only. It did not prevent two clean deterministic schema applications,
two final expanded security-suite passes, or reproduction from the recorded
SQL artifacts. It is not a Stage 2 closure blocker and its remediation is not
authorized by this closure task.

## Gate boundary

Stage 2 is closed and approved. Stage 3 remains not opened and no Stage 3 work
is authorized.
