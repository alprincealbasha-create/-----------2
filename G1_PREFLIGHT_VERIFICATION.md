# G1 Preflight Verification

Preflight ID: `G1-PREFLIGHT-01`  
Date: 2026-08-30  
Frozen authority: `RW-G0-FROZEN-001`  
Final result: **NOT READY FOR G1 EXECUTION**

## Verification matrix

| Check | Result | Evidence / consequence |
|---|---|---|
| G0 remains approved, closed, and frozen | PASS | No frozen G0 document was edited |
| G1 is open; G2–G12 remain unopened | PASS | No gate status was advanced |
| OD-014 Flutter/Dart choice recorded | PASS | Flutter 3.47.1 stable and bundled Dart 3.13.1 |
| OD-014 framework choices recorded | PASS | Riverpod, `go_router`, and `supabase_flutter` recorded |
| Application ID decision resolved | PASS WITH PENDING APPLICATION | Target is `com.rawdatwird.app`; prototype difference documented before any change |
| Minimum SDK decision resolved | **FAIL — COMPATIBILITY BLOCKER** | Owner target is API 23, but the current resolved `supabase_flutter` graph contains Android plugins requiring API 24 |
| Target/compile SDK resolved | PASS | API 36, matching installed stable Android SDK and Flutter 3.47.1 defaults |
| OD-025 device baseline recorded | PASS | Android phones/tablets; API 23; validation priority Android 8+ |
| Supported Android build/run evidence available | PENDING G1 EXIT | No connected Android target and no installed emulator image; one must be provisioned before G1 exit |
| Toolchain inspected with required commands | PASS | `flutter --version`, `dart --version`, and `flutter doctor -v` executed |
| Android toolchain has a blocking doctor issue | PASS (NONE) | Android SDK 36, Java 17, licenses accepted; Windows Visual Studio issue is out of scope |
| Git root understood | PASS | No `.git` existed in project root or any inspected parent before initialization |
| Copied-repository status understood | PASS WITH LIMITATION | No repository metadata existed, so prior repository provenance cannot be verified; the folder is treated only as an unversioned project snapshot |
| Local repository initialized | PASS | Git initialized at the project root; no remote configured and no push performed |
| Frozen baseline commit available | PASS | Commit `ebb2d73` — `chore: establish frozen G0 project baseline` |
| Flutter ignore policy adequate | PASS | Build/cache/local-property/keystore patterns are excluded |
| Secret exposure check | PASS | No credential-content match; `android/local.properties` ignored; no private-key/keystore/build/cache file staged |
| G2+ implementation performed by preflight | PASS (NONE) | Existing prototype code/migrations were preserved only as baseline; preflight created documentation and Git metadata only |
| OD-012 safety constraint respected | PASS | No external/unknown database or production state was accessed, reset, rebuilt, or overwritten |

## Git determination

Before initialization, `.git` was absent from:

- the project root;
- every inspected parent through the filesystem root.

No reliable evidence exists to prove whether the folder was copied from another repository, so that history is recorded as **not verifiable**, not guessed. A new local repository was initialized at the project root. There is no configured remote.

The baseline commit contains 267 existing project files and the frozen governance package. Ignored local caches, build output, `android/local.properties`, signing material, and credential-pattern files were not included.

## Blocking issue

`supabase_flutter 2.17.2` currently resolves Android plugins declaring API 24. This conflicts with the owner-approved API 23 minimum. Because the task prohibits silently raising the minimum and preflight does not authorize dependency mutation, the package graph must be reconciled before substantive G1 execution.

Acceptable resolution paths are limited to:

1. select and verify an API-23-compatible `supabase_flutter` dependency graph during an explicitly scoped G1 dependency-resolution task; or
2. obtain an explicit owner/change-control decision raising the minimum SDK.

The first path preserves the frozen device baseline and is recommended.

Separately, provision an Android emulator image or connect a supported physical device before G1 exit verification. This is an exit-evidence obligation, not authority to open another gate.

## Scope conclusion

Preflight documentation and the version-control baseline are complete, but the API 23 dependency contradiction prevents a `READY FOR G1 EXECUTION` conclusion.

Gate state remains:

- `G0 = APPROVED / CLOSED / FROZEN`
- `G1 = OPEN`
- `G2–G12 = NOT OPENED`
