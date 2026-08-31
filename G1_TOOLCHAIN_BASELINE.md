# G1 Toolchain Baseline

Status: **RECORDED — G1 PREFLIGHT READY**
Date: 2026-08-31
Authority: `GD-G0-FINAL`, `RW-G0-FROZEN-001`, OD-014, and the owner-approved limited OD-025 revision in `G1-PREFLIGHT-02`

## Selected owner baseline

| Item | Selected baseline |
|---|---|
| Primary platform | Android phones and tablets |
| Flutter | Installed stable Flutter `3.47.1` |
| Dart | Flutter-bundled Dart `3.13.1` |
| State management | Riverpod (`flutter_riverpod`) |
| Routing | `go_router` |
| Backend client foundation | `supabase_flutter`; client foundation only in G1 |
| Android application ID | `com.rawdatwird.app` |
| Minimum Android SDK | API 24 / Android 7.0 |
| Practical validation priority | Android 8.0/API 26 and newer |
| Compile SDK | API 36 |
| Target SDK | API 36 |
| iOS | Post-MVP release target |

The application ID, minimum SDK, compile SDK, and target SDK above are the owner-approved G1 target configuration. This preflight records them; it does not mutate the existing prototype.

## Actual installed environment

The required commands were run from the project root.

| Tool | Actual result |
|---|---|
| `flutter --version` | Flutter `3.47.1`, stable channel; framework revision `6655482ec0`; DevTools `2.60.0` |
| `dart --version` | Dart `3.13.1` stable, bundled with the selected Flutter SDK |
| Java | Microsoft OpenJDK `17.0.20.1+1-LTS`, selected in Flutter configuration |
| Android SDK | SDK `36.0.0`; platform `android-36`; build-tools `36.0.0` |
| Android licenses | All accepted |
| Android toolchain doctor result | PASS |
| Connected Android target | `emulator-5554`; Android 16/API 36; `android-x64`; boot completed |
| Installed Android emulator source | AVD `rawdat_wird_api36`, Pixel 7 profile, Google APIs x86_64 API 36 |

`flutter doctor -v` reported only the absence of Visual Studio for Windows desktop development. Windows desktop is outside the Android-first MVP and this is not a G1 Android blocker.

## Existing prototype differences

The current `android/app/build.gradle.kts` has not been changed by this preflight.

| Setting | Existing prototype | Approved target | Required G1 action |
|---|---|---|---|
| `applicationId` | `sa.wardalrawdah.ward_al_rawdah` | `com.rawdatwird.app` | Change explicitly during substantive G1 foundation work, including namespace/source alignment as needed |
| `minSdk` | `flutter.minSdkVersion`, resolving to API 24 in Flutter 3.47.1 | API 24 | Compatible; make the selected baseline explicit/reproducible during substantive G1 foundation work |
| `compileSdk` | `flutter.compileSdkVersion`, resolving to API 36 | API 36 | Compatible; make the selected baseline reproducible in G1 evidence |
| `targetSdk` | `flutter.targetSdkVersion`, resolving to API 36 | API 36 | Compatible; make the selected baseline reproducible in G1 evidence |

## Compatibility concerns

### API 24 dependency requirement — resolved by limited owner revision

The current resolved `supabase_flutter 2.17.2` dependency graph contains Android plugins whose installed Gradle declarations require API 24:

- `app_links 7.2.1` — `minSdk = 24`
- `shared_preferences_android 2.4.27` — `minSdk = 24`
- `url_launcher_android 6.3.32` — `minSdk = 24`

This requirement was discovered by reading `.flutter-plugins-dependencies`, resolving each Android plugin path, and inspecting the plugin's installed `android/build.gradle.kts`. Inspection of all resolved Android plugins found no declared minimum higher than API 24.

The owner revised OD-025 from API 23 to API 24 in `G1-PREFLIGHT-02`. API 24 now matches Flutter 3.47.1's default and the highest observed requirement in the resolved graph. No core dependency downgrade is required.

### Android run target — resolved

Android Studio is not installed, but it was not required. Command-line SDK tools installed Android Emulator `37.1.11` and `system-images;android-36;google_apis;x86_64`. Both official archives were reconstructed from safely resumed/non-overlapping byte ranges after SDK-manager download stalls and were verified against their repository sizes and SHA-1 values before installation.

AVD `rawdat_wird_api36` was created with a Pixel 7 profile and launched in development/test-only headless mode. ADB verified Android 16/API 36 and completed boot. `flutter devices` recognizes it as `emulator-5554`, an Android x64 mobile target. No preflight blocker remains.

## G1 boundary

No Supabase project, database, migration, RLS policy, authentication flow, role behavior, product feature, or production secret was created or changed in this preflight.
