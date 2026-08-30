# G1 Toolchain Baseline

Status: **RECORDED — COMPATIBILITY BLOCKER OPEN**  
Date: 2026-08-30  
Authority: `GD-G0-FINAL`, `RW-G0-FROZEN-001`, OD-014, OD-025

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
| Minimum Android SDK | API 23 / Android 6.0 |
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
| Connected Android target | None |
| Installed Android emulator source | None found |

`flutter doctor -v` reported only the absence of Visual Studio for Windows desktop development. Windows desktop is outside the Android-first MVP and this is not a G1 Android blocker.

## Existing prototype differences

The current `android/app/build.gradle.kts` has not been changed by this preflight.

| Setting | Existing prototype | Approved target | Required G1 action |
|---|---|---|---|
| `applicationId` | `sa.wardalrawdah.ward_al_rawdah` | `com.rawdatwird.app` | Change explicitly during substantive G1 foundation work, including namespace/source alignment as needed |
| `minSdk` | `flutter.minSdkVersion`, resolving to API 24 in Flutter 3.47.1 | API 23 | Set explicitly only after dependency compatibility is resolved |
| `compileSdk` | `flutter.compileSdkVersion`, resolving to API 36 | API 36 | Compatible; make the selected baseline reproducible in G1 evidence |
| `targetSdk` | `flutter.targetSdkVersion`, resolving to API 36 | API 36 | Compatible; make the selected baseline reproducible in G1 evidence |

## Compatibility concerns

### API 23 dependency conflict — blocking

The current resolved `supabase_flutter 2.17.2` dependency graph contains Android plugins whose installed Gradle declarations require API 24:

- `app_links 7.2.1` — `minSdk = 24`
- `shared_preferences_android 2.4.27` — `minSdk = 24`
- `url_launcher_android 6.3.32` — `minSdk = 24`

The current package graph therefore cannot substantiate the owner-approved API 23 floor. G1 must select and verify a compatible dependency resolution that preserves `supabase_flutter` while supporting API 23, or return an explicit owner/change-control decision before raising the minimum. The minimum must not be raised silently.

Flutter 3.47.1 accepts API 23 but warns below its default API 24; API 23 is its error floor in the installed toolchain. This makes physical/emulator validation on a supported target especially important.

### Android run target — exit obligation

No Android device is connected and no Android Virtual Device image is installed. This does not invalidate the installed Android toolchain, but G1 cannot satisfy its build-and-run exit evidence until a supported emulator or physical device is available.

## G1 boundary

No Supabase project, database, migration, RLS policy, authentication flow, role behavior, product feature, or production secret was created or changed in this preflight.
