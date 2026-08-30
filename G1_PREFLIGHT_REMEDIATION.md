# G1 Preflight Remediation Record

Remediation ID: `G1-PREFLIGHT-02`
Date: 2026-08-30
Authority: owner instruction `G1-PREFLIGHT-02`; frozen baseline `RW-G0-FROZEN-001` remains authoritative except for the explicit limited OD-025 revision below
Final status: **NOT READY FOR G1 EXECUTION**

## 1. Original blockers

1. The approved API 23 minimum conflicted with the resolved Android dependency graph associated with `supabase_flutter 2.17.2`.
2. No Android emulator or physical device was available for runtime verification.

## 2. Limited OD-025 revision

The owner revised only the G1 Android compatibility floor:

| Setting | Previous | Revised authoritative G1 value |
|---|---:|---:|
| Minimum SDK | API 23 / Android 6.0 | API 24 / Android 7.0 |
| Compile SDK | API 36 | API 36 |
| Target SDK | API 36 | API 36 |

Android phones and tablets remain the primary MVP target, Android 8.0+ remains the practical validation priority, and iOS release remains post-MVP. No unrelated G0 decision was reopened.

## 3. Exact dependency evidence

The project's `.flutter-plugins-dependencies` file was parsed to obtain resolved Android plugin paths. Each installed plugin Gradle file was then inspected for a numeric `minSdk` declaration.

| Dependency | Resolved version | Observed declaration | Evidence location/method |
|---|---:|---:|---|
| `app_links` | `7.2.1` | API 24 | Installed `android/build.gradle.kts`: `minSdk = 24` |
| `shared_preferences_android` | `2.4.27` | API 24 | Installed `android/build.gradle.kts`: `minSdk = 24` |
| `url_launcher_android` | `6.3.32` | API 24 | Installed `android/build.gradle.kts`: `minSdk = 24` |

These are transitive Android plugins in the current `supabase_flutter` foundation graph. Inspection of the complete resolved Android plugin list found no numeric declaration higher than API 24. The dependency blocker is therefore resolved by the limited owner revision, without package downgrade or lock-file mutation.

## 4. Android device/emulator setup result

Initial state:

- `flutter emulators`: no emulator sources;
- `flutter devices`: Windows, Chrome, and Edge only; no Android target;
- `avdmanager list avd`: no AVD;
- Android Studio: not installed;
- command-line `sdkmanager`, `avdmanager`, and `adb`: installed;
- Emulator package and Android system images: not installed.

Requested setup:

- Android Emulator `37.1.11`;
- Android API 36 Google APIs x86_64 system image;
- intended development/test-only AVD after installation.

The deprecated `sdkmanager` reached `Preparing "Install Android Emulator v.37.1.11"` but created a zero-byte archive and stopped progressing. The newer `android sdk` bootstrap also stalled. Direct HTTPS verification of the official archive succeeded (`200 OK`, 441,926,448 bytes). A resumable direct download then transferred at about 122–140 KiB/s and was stopped at 6,254,592 bytes (about 5.96 MiB) because the emulator archive alone was estimated to require about one hour, before downloading the larger system image.

Result: no emulator package, system image, AVD, or Android runtime target is yet available. The device blocker remains open.

## 5. Commands executed

Read-only/environment checks:

```text
flutter emulators --no-version-check
flutter devices --no-version-check
avdmanager.bat list avd
sdkmanager.bat --list_installed
flutter doctor -v
```

Setup attempts:

```text
sdkmanager.bat emulator system-images;android-36;google_apis;x86_64
sdkmanager.bat --verbose emulator system-images;android-36;google_apis;x86_64
android.exe sdk --help
curl.exe -I https://dl.google.com/android/repository/emulator-windows_x64-15917651.zip
curl.exe -L --fail --retry 3 --continue-at - --output <SDK temporary archive> <official archive URL>
```

No Supabase environment, production database, migration, application feature, or real user data was accessed.

## 6. Remaining risks and remediation

- Complete or resume installation of the official Emulator and API 36 system image when adequate download throughput is available, then create and launch a development/test-only AVD.
- Alternatively, connect an authorized physical Android device running API 24 or newer; Android 8.0+ is preferred.
- Re-run `flutter devices` and require an Android target before declaring preflight ready.
- Substantive G1 implementation and all G2+ work remain prohibited while this preflight result is not ready.

## 7. Final readiness

- Dependency/API blocker: **RESOLVED**.
- Android target blocker: **OPEN**.
- Git baseline: valid; final documentation commit required before reporting clean status.
- G2+ implementation: none.

Final result: **NOT READY FOR G1 EXECUTION**.

Gate state remains:

- `G0 = APPROVED / CLOSED / FROZEN`
- `G1 = OPEN`
- `G2–G12 = NOT OPENED`
