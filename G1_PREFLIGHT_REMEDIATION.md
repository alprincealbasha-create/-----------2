# G1 Preflight Remediation Record

Remediation ID: `G1-PREFLIGHT-02`
Date: 2026-08-31
Authority: owner instruction `G1-PREFLIGHT-02`; frozen baseline `RW-G0-FROZEN-001` remains authoritative except for the explicit limited OD-025 revision below
Final status: **READY FOR G1 EXECUTION**

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

The deprecated `sdkmanager` reached `Preparing "Install Android Emulator v.37.1.11"` but initially created a zero-byte archive and stopped progressing. The newer `android sdk` bootstrap also stalled. Direct HTTPS verification of the official archive succeeded. Its existing partial download was resumed, not restarted, and the remaining byte ranges were downloaded separately. The assembled 441,926,448-byte archive matched the official SHA-1 `54fa750822ff462d57e04fc8e98e60f08df2bb61`. Android Emulator `37.1.11` then installed successfully.

The API 36 Google APIs x86_64 system image download exhibited the same SDK-manager stall. Its exact repository metadata was read for package `system-images;android-36;google_apis;x86_64`. Non-overlapping byte ranges were downloaded and resumed without discarding completed data. The assembled image was exactly 1,895,447,397 bytes and matched official SHA-1 `c6bf44bdcd885bb902b4ba752d111a073ad7a817`; installation succeeded.

AVD result:

- name: `rawdat_wird_api36`;
- hardware profile: Pixel 7;
- system image: Google APIs x86_64 API 36;
- Android release: 16;
- ADB identifier: `emulator-5554`;
- boot verification: `sys.boot_completed=1`;
- Flutter status: recognized as an Android mobile target.

The device blocker is closed.

## 5. Commands executed

Read-only/environment checks:

```text
flutter emulators --no-version-check
flutter devices --no-version-check
avdmanager.bat list avd
sdkmanager.bat --list_installed
flutter doctor -v
adb devices -l
adb -s emulator-5554 shell getprop sys.boot_completed
adb -s emulator-5554 shell getprop ro.build.version.release
adb -s emulator-5554 shell getprop ro.build.version.sdk
```

Setup attempts:

```text
sdkmanager.bat emulator system-images;android-36;google_apis;x86_64
sdkmanager.bat --verbose emulator system-images;android-36;google_apis;x86_64
android.exe sdk --help
curl.exe -I https://dl.google.com/android/repository/emulator-windows_x64-15917651.zip
curl.exe -L --fail --retry 3 --continue-at - --output <SDK temporary archive> <official archive URL>
curl.exe --range <start-end> --output <verified temporary part> <official archive URL>
sdkmanager.bat --verbose emulator
sdkmanager.bat --verbose system-images;android-36;google_apis;x86_64
avdmanager.bat create avd --name rawdat_wird_api36 --package system-images;android-36;google_apis;x86_64 --device pixel_7
emulator.exe -avd rawdat_wird_api36 -no-window -no-audio -no-boot-anim -no-snapshot-save
flutter devices --no-version-check
```

No Supabase environment, production database, migration, application feature, or real user data was accessed.

## 6. Remaining risks and controls

- The local AVD is development/test-only and may need to be recreated on another workstation.
- `avdmanager` emitted a non-blocking warning while reading a system-image `devices.xml`; creation, launch, ADB boot verification, and Flutter discovery all succeeded despite it.
- The current task proves target availability only. Building/running the minimal foundation remains substantive G1 verification, not preflight work.
- Opening G2 remains prohibited until G1 implementation, exit evidence, and owner approval are complete.

## 7. Final readiness

- Dependency/API blocker: **RESOLVED**.
- Android target blocker: **RESOLVED**.
- Git baseline: valid; working tree must be clean after recording this closure update.
- G2+ implementation: none.

Final result: **READY FOR G1 EXECUTION**.

Gate state remains:

- `G0 = APPROVED / CLOSED / FROZEN`
- `G1 = OPEN`
- `G2–G12 = NOT OPENED`
