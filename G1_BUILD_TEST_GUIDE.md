# G1 Build and Test Guide

Status: **G1 FOUNDATION COMMANDS**

Primary target: Android emulator `emulator-5554` (AVD `rawdat_wird_api36`)

On Windows, the Android Gradle plugin rejects this checkout's Arabic path. Use
an ASCII-only checkout path in normal development/CI, or create a temporary
junction to this checkout and run Flutter commands from the junction:

```powershell
$projectPath = (Get-Location).Path
$junctionPath = Join-Path $env:TEMP 'rawdat_wird_g1'
New-Item -ItemType Junction `
  -Path $junctionPath `
  -Target $projectPath
Set-Location $junctionPath
```

The junction is a tooling workaround only: it points to the same files and
does not copy or change the repository. Do not add
`android.overridePathCheck=true`; suppressing the check does not guarantee that
all native Android tools can process a non-ASCII Windows path.

## Foundation verification without backend configuration

The no-configuration path intentionally launches a safe RTL configuration
notice and does not contact Supabase.

```powershell
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
flutter run -d emulator-5554 --debug
```

Stop the interactive run after confirming that the application launches and
shows the configuration notice without crashing.

## Optional isolated development/test configuration

Copy `config/dart_defines.example.json` to the ignored
`config/dart_defines.development.json` and replace its public placeholders with
values for an isolated development/test project only.

```powershell
flutter run -d emulator-5554 --debug `
  --dart-define-from-file=config/dart_defines.development.json
```

G1 does not require or authorize applying Supabase migrations, creating users,
testing authentication, or connecting to any existing/unknown environment.

## Expected platform baseline

- Flutter 3.47.1 stable / Dart 3.13.1
- Android application ID `com.rawdatwird.app`
- minimum SDK 24; compile SDK 36; target SDK 36
- Android 16/API 36 emulator recognized as `emulator-5554`
- Java 17

## Secrets and local files

Do not commit environment-specific Dart-define files, `.env` files,
`android/local.properties`, keystores, database passwords, access/refresh
tokens, or `service_role` credentials. Only
`config/dart_defines.example.json` is a versioned configuration example.

## Known non-blocking tool warning

The current Android build may report that one SDK metadata parser understands
XML through version 3 while installed platform metadata uses version 4. The
verified build still produces an API 36 APK and the application cold-starts
without runtime errors. Treat a future build failure differently; do not ignore
an actual incompatibility merely because this warning was non-blocking here.
