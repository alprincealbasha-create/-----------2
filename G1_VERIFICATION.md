# G1 Verification

Status: **PASS — G1 FOUNDATION VERIFIED**

Date: 2026-08-31

Frozen authority: `RW-G0-FROZEN-001`

Starting baseline: `7c81dfdddf0442b582bf7c0bf34c2b2778b7c293`

## 1. Authoritative scope

G1 establishes only the Git/Flutter/Android foundation, approved dependency
baseline, safe configuration template, localization/RTL foundation, minimal
structure notes, and reproducible analyze/test/build/run evidence. It does not
implement or modify any database, migration, RLS policy, authentication flow,
user/branch/class CRUD, Dhikr/Wird behavior, Drift schema, synchronization,
reward, dashboard, report, or release-signing behavior.

`IMPLEMENTATION_PLAN.md` is not present. `CODEX_PLAN.md`,
`G1_EXECUTION_BRIEF.md`, and `GATE_ACCEPTANCE_MATRIX.md` provide the governing
plan and acceptance contract. Historical unresolved prerequisite rows in the
execution brief were superseded by the later G1 preflight evidence; no active
scope contradiction remained.

## 2. Baseline and environment

- Pre-change HEAD matched `7c81dfd`; the working tree was clean.
- Flutter 3.47.1 stable; Dart 3.13.1; DevTools 2.60.0.
- Windows 11 Pro 25H2; Java 17.0.20.1.
- Android SDK 36.0.0; build-tools 36.0.0; emulator 37.1.11.
- AVD `rawdat_wird_api36`; device `emulator-5554`; Android 16/API 36.
- `flutter doctor -v`: Flutter, Android toolchain, licenses, device, and network
  passed. Missing Visual Studio affects Windows desktop only and is outside the
  Android-first G1 scope.

## 3. Commands and results

| Verification | Result | Evidence |
|---|---|---|
| `flutter pub get --no-example` | PASS | Dependencies resolved; no `pubspec.lock` diff |
| Dart format check over `lib test` | PASS | 154 files checked; no pending format change |
| `flutter analyze --no-pub` | PASS | Final rerun: `No issues found` in 78.4 seconds from the ASCII junction |
| G1 smoke test | PASS | 3/3 tests passed |
| `flutter test --no-pub` | PASS | 63/63 tests passed |
| `flutter build apk --debug --no-pub` | PASS | `app-debug.apk` built in 285.6 seconds after required SDK components were available |
| APK metadata via `aapt dump badging` | PASS | package `com.rawdatwird.app`; min SDK 24; target/compile SDK 36; label `ورد الروضة` |
| `flutter run -d emulator-5554 --debug --no-pub` | PASS WITH TOOLING NOTE | APK built, installed, and process launched; DevFS later disconnected |
| independent ADB cold start | PASS | `Status: ok`, `LaunchState: COLD`, activity `com.rawdatwird.app/.MainActivity`, total time 7213 ms |
| runtime process/focus | PASS | package installed, process alive, and MainActivity focused |
| UI hierarchy/screenshot | PASS | safe Arabic configuration message visible under package `com.rawdatwird.app` |
| filtered runtime log | PASS | no `AndroidRuntime`, Flutter framework, or uncaught exception found |
| secret/config scan | PASS | zero credential-content matches and zero tracked sensitive-file matches |

APK evidence at verification time:

- path: `build/app/outputs/flutter-apk/app-debug.apk` (ignored build artifact);
- size: 177,242,322 bytes;
- SHA-256: `C05FBD8F50CE81ECBB16D9A578844C68C21EEF4553B1C15D6B1C122F3848A1FD`.

## 4. Remediation during verification

- The initial RTL smoke assertion selected `MaterialApp`'s outer directionality
  instead of the directionality nearest the message. The assertion was narrowed
  to the message ancestor and then passed; no application code changed.
- Android Platform 35 and CMake 3.22.1 were installed as official local SDK
  components required by pre-existing native plugin builds. No project
  dependency was added or changed.
- The Windows non-ASCII checkout limitation was isolated with a temporary ASCII
  junction. The same repository files were analyzed and built without copying
  or changing architecture.

## 5. Known limitations and warning classification

### Windows Arabic checkout path — ENVIRONMENTAL / MODERATE

- Direct `flutter analyze` from the Arabic path caused the Dart analysis-server
  LSP channel to receive truncated JSON while processing the percent-encoded
  workspace URI.
- Direct Android build from that path was rejected by the Android Gradle plugin
  non-ASCII path check. Manual `aapt` access also failed on the direct Unicode
  path.
- This does not affect the APK, installed application, or runtime. It does
  affect local build/analyze reproducibility when commands are run directly
  from this Windows path.
- The validated workaround is an ASCII-only checkout path or temporary
  junction. CI is unaffected when its workspace path is ASCII-only.
- No architecture change is required. The limitation and exact workaround are
  documented in `G1_BUILD_TEST_GUIDE.md`.

### Android SDK XML warning — ENVIRONMENTAL / MINOR

- Gradle's SDK-processing layer reported that one metadata parser understands
  XML versions through 3 while installed Android platform metadata includes
  repository schema version 4.
- Command-line tools are 22.0, Android Gradle Plugin is 9.1.0, compile/target
  SDK are 36, and the resulting APK metadata and runtime were verified.
- The warning did not cause a build, packaging, installation, or runtime
  failure. No immediate remediation is justified; re-evaluate it when the
  Android/Flutter toolchain is upgraded or if it becomes an error.

### Other non-blocking tooling observations

- Flutter DevFS disconnected after the first debug launch, but the installed
  process remained active. A separate ADB cold start passed with clean logs.
- Visual Studio is absent; Windows desktop is outside the Android-first MVP.

## 6. Independent diff review

Review scope covered every tracked and untracked G1 change. Findings:

- `CRITICAL`: none.
- `MAJOR`: none.
- `MODERATE`: none in project changes. The Arabic checkout limitation is an
  environmental limitation with a validated workaround.
- `MINOR`: the non-blocking SDK XML warning and intermittent DevFS disconnect;
  both have independent successful build/runtime evidence.

The review found no hard-coded machine path in committed project files, no
machine-specific generated artifact, no new dependency, no application-ID or
SDK mismatch, no localization/RTL defect, and no G2+ implementation change.
The debug APK is intentionally unsigned for release purposes; release signing
and distribution remain G12 work.

## 7. OD-012 and gate boundary

No Supabase environment, external database, production state, migration, real
child data, reset, rebuild, deletion, or overwrite was used. Only local project
files, placeholder configuration, synthetic tests, ignored build artifacts, and
the isolated Android emulator were touched. G2 remains not opened.

## 8. Acceptance conclusion

All executable G1 acceptance criteria pass, no blocking warning exists, the
tracked dependency lock remains unchanged, and no CRITICAL or MAJOR review
finding remains. G1 may be closed under the owner's Stage 1 closure order while
G2 remains not opened.
