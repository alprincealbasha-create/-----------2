# G1 Dependency Manifest

Status: **G1 VERIFIED — LOCK UNCHANGED — COMPATIBLE WITH OWNER-APPROVED API 24**
Date: 2026-08-30

This manifest distinguishes the owner-approved G1 foundation from packages already present in the prototype. No package was added, removed, upgraded, or downgraded during preflight.

Substantive G1 execution also required no dependency mutation. `flutter pub get`
completed successfully, `pubspec.lock` remained unchanged and tracked, and the
full analyzer, test, Android build, and runtime checks passed with the versions
recorded below.

## Approved G1 foundation dependencies

| Package | Exact resolved version | Purpose | Why required in G1 | Kind | minSdk effect | Native configuration |
|---|---:|---|---|---|---|---|
| `flutter` | SDK `3.47.1` (`0.0.0` in lock) | Application framework | Required platform foundation | Runtime SDK | Default and approved minimum are API 24 | Android Gradle/manifest foundation |
| `flutter_riverpod` | `3.4.2` | Single state-management system | Freezes the approved state-management choice without product state implementation | Runtime | No direct Android minimum found | None |
| `go_router` | `18.0.0` | Single routing system | Freezes the approved navigation foundation without role routing | Runtime | No direct Android minimum found | None |
| `supabase_flutter` | `2.17.2` | Supabase client foundation | Establishes the approved backend client only; no database/auth work in G1 | Runtime | Transitive Android graph requires API 24; compatible with the revised baseline | Includes Android plugins and generated plugin registration |
| `flutter_test` | Flutter SDK `0.0.0` | Foundation smoke tests | Required for the G1 test exit check | Dev | No production minSdk change | None |
| `flutter_lints` | `6.0.0` | Static-analysis rules | Required for a consistent `flutter analyze` baseline | Dev | None | None |

`flutter_localizations 0.0.0` is present as an SDK runtime dependency in the prototype. It may be retained only if G1 documents a concrete Arabic/localization foundation need; it is not an authorization to build product UI.

## Native compatibility trace for `supabase_flutter`

The following resolved transitive Android plugins were inspected from `.flutter-plugins-dependencies`:

| Transitive plugin | Resolved version | Declared Android minimum | Result |
|---|---:|---:|---|
| `app_links` | `7.2.1` | API 24 | Compatible with revised baseline |
| `shared_preferences_android` | `2.4.27` | API 24 | Compatible with revised baseline |
| `url_launcher_android` | `6.3.32` | API 24 | Compatible with revised baseline |
| `connectivity_plus` | `7.3.1` | API 21 | Below revised baseline; not required for G1 foundation |

Evidence method: `.flutter-plugins-dependencies` was parsed to obtain every resolved Android plugin path, then each installed Gradle declaration was inspected for `minSdk`. The three plugins above declared API 24. `connectivity_plus`, `jni`, and `jni_flutter` declared API 21; the remaining observed Android plugins did not declare a higher numeric minimum in their package Gradle file. No approved G1 dependency was observed to require more than API 24.

The owner-approved limited OD-025 revision in `G1-PREFLIGHT-02` changes the project floor from API 23 to API 24. The current lock file therefore needs no downgrade or dependency mutation for minimum-SDK compatibility.

## Pre-existing prototype packages not approved as G1 needs

These direct dependencies remain in the captured prototype baseline because removing them would modify existing feature code. Their presence is inventory, not authorization to implement their later-gate behavior.

| Package | Exact resolved version | Existing purpose | Kind | G1 disposition | Native/minSdk note |
|---|---:|---|---|---|---|
| `connectivity_plus` | `7.3.1` | Connectivity observation | Runtime | Defer functional use to G7; review during G1 dependency rationalization | Android plugin; declares API 21, below baseline |
| `drift` | `2.34.3` | Local relational persistence | Runtime | Defer functional use to G6 | Dart package |
| `drift_flutter` | `0.3.1` | Flutter integration for Drift | Runtime | Defer functional use to G6 | Pulls native storage/path components; verify final graph |
| `freezed_annotation` | `3.1.0` | Generated immutable-model annotations | Runtime | Existing code-generation framework; not newly justified by G1 | No direct native configuration |
| `json_annotation` | `4.12.0` | JSON annotations | Runtime | Existing serialization support; not newly justified by G1 | No direct native configuration |
| `build_runner` | `2.16.0` | Code generation runner | Dev | Existing prototype only; no new code generation in preflight | None |
| `freezed` | `4.0.0` | Freezed generator | Dev | Existing prototype only | None |
| `json_serializable` | `6.14.1` | JSON generator | Dev | Existing prototype only | None |
| `drift_dev` | `2.34.5` | Drift generator/tooling | Dev | Existing prototype only | None |

## Dependency rules for substantive G1

1. Keep Riverpod as the only state manager and `go_router` as the only router.
2. Do not add an HTTP client, analytics SDK, background-task framework, or production secret.
3. Do not implement Supabase database, migrations, RLS, authentication, or roles.
4. Keep `minSdk` at API 24 unless a later owner-approved change-control decision modifies it.
5. Record every dependency change and its justification; commit the resulting lock file.
