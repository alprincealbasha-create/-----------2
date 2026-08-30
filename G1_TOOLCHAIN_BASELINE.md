# G1 Toolchain Baseline

Status: **RECORDED — DEPENDENCY COMPATIBILITY RESOLVED; DEVICE BLOCKER OPEN**
Date: 2026-08-30  
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
| Connected Android target | None after re-verification |
| Installed Android emulator source | None; installation was attempted but could not complete in this environment |

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

### Android run target — blocking

Android Studio is not installed. Command-line SDK tools, `sdkmanager`, `avdmanager`, and `adb` are available, but the Emulator package and system images were absent. Installation of Emulator `37.1.11` and an API 36 Google APIs x86_64 image was attempted. The legacy SDK manager stalled after creating a zero-byte archive; direct access to the official 421.4 MiB emulator archive succeeded but transferred at about 122–140 KiB/s, implying roughly one hour for that archive before the larger system image. The transfer was stopped at 6,254,592 bytes (about 5.96 MiB) and remains resumable in the SDK temporary directory.

No Android Virtual Device could therefore be created or launched, and `flutter devices` still has no Android target. This remains the only preflight blocker.

## G1 boundary

No Supabase project, database, migration, RLS policy, authentication flow, role behavior, product feature, or production secret was created or changed in this preflight.
