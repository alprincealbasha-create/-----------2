# G1 Execution Brief — Project Foundation

Brief status: **PRODUCED AND CHECKED — SUBSTANTIVE G1 IMPLEMENTATION NOT STARTED**  
Authority: `GD-G0-FINAL`, `RW-G0-FROZEN-001`  
Gate state: `G1 = OPEN`; `G2–G12 = NOT OPENED`

## 1. Exact objective

Establish the Flutter/Android project foundation, approved packages, non-secret configuration, and minimal project structure **without implementing any product feature**.

The basic application must build and run, `flutter analyze` and `flutter test` must pass, and no secret may be present in the project.

## 2. Prerequisites

| Prerequisite | Current result | Effect |
|---|---|---|
| G0 approved/closed/frozen | SATISFIED | `GD-G0-FINAL` and `RW-G0-FROZEN-001` |
| Frozen G0 baseline available | SATISFIED | this brief was checked against its authority and safety constraints |
| Prototype inventory preserved | SATISFIED FOR STARTUP | existing Flutter/prototype/migration files remain present and were not deleted or rewritten by this task |
| OD-012 safety constraint active | SATISFIED AS CONTROL | only isolated/non-destructive work is allowed; unknown state is not empty |
| OD-014 subset required for G1 | **NOT YET RESOLVED** | blocks substantive foundation mutation until Flutter/Dart versions, approved package versions, application ID, and Android minimum baseline are recorded |
| OD-025 subset required for G1 | **NOT YET RESOLVED** | blocks device-targeted verification until Android device/API floor is recorded; signing custody/distribution remains for G12 |
| Version-control evidence | NOT AVAILABLE | no `.git` directory is visible; does not prevent preparing decisions, but blocks the exit requirement that the package lock be committed unless repository state is restored or explicitly initialized in G1 |

## 3. Work allowed in G1

- Inspect and inventory the existing Flutter prototype without treating it as passed work.
- Resolve and record the G1-required portions of OD-014 and OD-025.
- Initialize or align the Flutter/Android foundation after prerequisites are resolved.
- Add only approved packages with a written justification and pinned compatible versions.
- Establish non-secret environment/configuration templates.
- Establish the smallest useful `core/shared/features` structure; do not create empty folders merely to mirror a diagram.
- Add a minimal app shell/smoke test solely to prove foundation build/run.
- Create isolated local/test tooling or synthetic fixtures only when they cannot touch unknown authoritative state.
- Run formatting, `flutter analyze`, `flutter test`, Android build/run checks, and a secret scan.
- Document build/test commands and foundation decisions.

## 4. Work prohibited in G1

- Any G2 database table, PostgreSQL migration, RLS policy, seed for a real/unknown project, or Supabase schema initialization.
- Authentication, sessions, PIN exchange, roles implementation, or routing by role.
- Organization/branch/class/user CRUD.
- Dhikr/Wird domain behavior, counter, Drift persistence, synchronization, dashboard, rewards, reports, or release functionality.
- Any feature from G2–G12, even if prototype code already exists.
- Destructive reset/rebuild/overwrite/delete against existing or unknown state, or assuming unknown state is empty.
- Secrets, service-role credentials, signing material, or real child/customer data in the repository.
- Unrelated refactoring or deleting prototype files to make the new structure look clean.
- Opening G2 or claiming G1 complete before evidence and owner approval.

## 5. Required G1 artifacts

The future G1 execution must produce at least:

1. a runnable minimal Flutter/Android foundation and package lock;
2. `G1_DEPENDENCY_MANIFEST.md` with package/version/justification and OD-014 decisions;
3. a non-secret configuration template and environment-variable inventory;
4. `G1_STRUCTURE_NOTE.md` describing the minimal folder/layout choices and preserved prototype areas;
5. `G1_BUILD_TEST_GUIDE.md` with reproducible build, analyze, test, and run commands;
6. `G1_VERIFICATION.md` containing tool versions, Android target evidence, analyze/test/build/run results, secret-scan result, changed-file inventory, and OD-012 compliance;
7. version-control evidence that the dependency lock and foundation artifacts are recorded, or an explicitly approved equivalent if repository metadata is unavailable.

## 6. Verification requirements

- Minimal app builds and runs on an Android emulator or approved device target.
- `flutter analyze` succeeds with no blocking warning/error.
- `flutter test` succeeds.
- Secret scan finds no credential, service-role key, signing material, or real personal data.
- Dependency lock exists and is version-controlled under the approved repository process.
- No product feature or future-Gate artifact was introduced.
- Changed files are limited to G1 foundation scope.
- OD-012 evidence shows no existing/unknown environment was reset, overwritten, or treated as empty.

## 7. Exact G1 exit criteria

G1 may be recommended for owner approval only when:

1. the basic Flutter application builds and runs on the approved Android target;
2. `flutter analyze` and `flutter test` pass;
3. no blocking warning remains;
4. the approved dependency lock is recorded in version control;
5. the secret scan is clean;
6. all required G1 artifacts and reproducible evidence exist;
7. OD-014 and the G1 portion of OD-025 are resolved;
8. the OD-012 safety constraint was respected;
9. no G2+ feature was implemented;
10. the Human Owner approves G1 and explicitly opens G2.

## 8. Frozen-baseline cross-check

| Frozen concern | G1 guard |
|---|---|
| Limited institutional MVP | no product feature is implemented in G1 |
| Android first | foundation and verification target Android only; iOS is not intentionally broken but is not an exit target |
| Canonical roles/data model | no placeholder implementation of old `member/admin` or legacy schema is introduced |
| Offline-first contract | no counter/sync implementation is started early |
| Child privacy | no real child data or extra fields/fixtures are introduced |
| Database-level security | no UI-only authorization implementation is started in G1 |
| OD-012 | only isolated, non-destructive foundation work is permitted |
| Gate sequence | G2–G12 remain closed |

## 9. Execution readiness conclusion

G1 is **OPEN**, but substantive foundation execution is **not yet ready** until the G1-required portions of OD-014 and OD-025 are resolved. Repository/version-control availability must also be addressed before G1 can exit.

No G1 implementation was performed while preparing this brief.

