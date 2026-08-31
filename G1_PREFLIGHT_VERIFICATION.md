# G1 Preflight Verification

Preflight ID: `G1-PREFLIGHT-02`
Date: 2026-08-31
Frozen authority: `RW-G0-FROZEN-001`
Final result: **READY FOR G1 EXECUTION**

## Verification matrix

| Check | Result | Evidence / consequence |
|---|---|---|
| G0 remains approved, closed, and frozen | PASS | No frozen G0 document was edited |
| G1 is open; G2–G12 remain unopened | PASS | No gate status was advanced |
| OD-014 Flutter/Dart choice recorded | PASS | Flutter 3.47.1 stable and bundled Dart 3.13.1 |
| OD-014 framework choices recorded | PASS | Riverpod, `go_router`, and `supabase_flutter` recorded |
| Application ID decision resolved | PASS WITH PENDING APPLICATION | Target is `com.rawdatwird.app`; prototype difference documented before any change |
| Minimum SDK decision resolved | PASS | Limited owner revision sets API 24, matching Flutter 3.47.1 and the highest observed resolved dependency requirement |
| Target/compile SDK resolved | PASS | API 36, matching installed stable Android SDK and Flutter 3.47.1 defaults |
| OD-025 device baseline recorded | PASS | Android phones/tablets; API 24; validation priority Android 8+; iOS post-MVP |
| Supported Android device/emulator available | PASS | Running `rawdat_wird_api36` AVD is recognized by Flutter as `emulator-5554`, Android 16/API 36, `android-x64` |
| Toolchain inspected with required commands | PASS | `flutter --version`, `dart --version`, and `flutter doctor -v` executed |
| Android toolchain has a blocking doctor issue | PASS (NONE) | Android SDK 36, Java 17, licenses accepted; Windows Visual Studio issue is out of scope |
| Git root understood | PASS | No `.git` existed in project root or any inspected parent before initialization |
| Copied-repository status understood | PASS WITH LIMITATION | No repository metadata existed, so prior repository provenance cannot be verified; the folder is treated only as an unversioned project snapshot |
| Local repository initialized | PASS | Git initialized at the project root; no remote configured and no push performed |
| Frozen baseline commit available | PASS | Commit `ebb2d73` — `chore: establish frozen G0 project baseline` |
| Flutter ignore policy adequate | PASS | Build/cache/local-property/keystore patterns are excluded |
| Secret exposure check | PASS | No credential-content match; `android/local.properties` ignored; no private-key/keystore/build/cache file staged |
| G2+ implementation performed by preflight | PASS (NONE) | Existing prototype code/migrations were preserved only as baseline; preflight changed documentation and development tooling only |
| OD-012 safety constraint respected | PASS | No external/unknown database or production state was accessed, reset, rebuilt, or overwritten |

## Git determination

Before initialization, `.git` was absent from:

- the project root;
- every inspected parent through the filesystem root.

No reliable evidence exists to prove whether the folder was copied from another repository, so that history is recorded as **not verifiable**, not guessed. A new local repository was initialized at the project root. There is no configured remote.

The baseline commit contains 267 existing project files and the frozen governance package. Ignored local caches, build output, `android/local.properties`, signing material, and credential-pattern files were not included.

## Dependency compatibility resolution

The owner revised OD-025 from API 23 to API 24. The resolved `app_links 7.2.1`, `shared_preferences_android 2.4.27`, and `url_launcher_android 6.3.32` plugins each declare API 24. No resolved approved G1 dependency was observed to require more than API 24. The dependency blocker is closed without downgrading packages.

## Android runtime-target resolution

Initial inspection found:

- no physical Android device;
- no existing AVD;
- no Android Studio installation;
- command-line SDK tooling is available;
- no Emulator package or system image installed.

The physical-device recheck found no ADB device. The existing official Emulator archive was resumed rather than restarted, assembled from verified byte ranges, and validated against its repository SHA-1 (`54fa750822ff462d57e04fc8e98e60f08df2bb61`). Android Emulator `37.1.11` was then installed.

The official API 36 Google APIs x86_64 image was downloaded in non-overlapping ranges, assembled to exactly 1,895,447,397 bytes, and validated against its repository SHA-1 (`c6bf44bdcd885bb902b4ba752d111a073ad7a817`) before installation.

AVD `rawdat_wird_api36` was created with the Pixel 7 hardware profile and launched in development/test-only headless mode. ADB reported `sys.boot_completed=1`, Android release `16`, and SDK `36`. Final `flutter devices` evidence:

```text
sdk gphone64 x86 64 (mobile) • emulator-5554 • android-x64 • Android 16 (API 36) (emulator)
```

`flutter emulators` also lists `rawdat_wird_api36`. The runtime-target blocker is closed.

## Scope conclusion

Both preflight blockers are resolved. At least one supported Android target is running and recognized by Flutter. The result is **READY FOR G1 EXECUTION**.

Gate state remains:

- `G0 = APPROVED / CLOSED / FROZEN`
- `G1 = OPEN`
- `G2–G12 = NOT OPENED`
