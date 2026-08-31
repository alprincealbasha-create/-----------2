# G1 Structure Note

Status: **G1 FOUNDATION VERIFIED AND CLOSED**

Frozen authority: `RW-G0-FROZEN-001`

Gate boundary: `G1 = APPROVED / CLOSED`; `G2–G12 = NOT OPENED`

## Foundation established in G1

- Flutter package identity remains `ward_al_rawdah` to avoid an unrelated
  repository-wide import rewrite.
- Android uses the owner-approved application ID and namespace
  `com.rawdatwird.app`.
- Android platform values are explicit and reproducible: minimum SDK 24,
  compile SDK 36, and target SDK 36.
- The Android launcher label is the existing product name `ورد الروضة`.
- `config/` contains a versioned, non-secret Dart-define example and its
  variable inventory. Environment-specific copies are ignored.
- `test/app/` contains the minimal G1 smoke coverage for configuration and the
  safe no-configuration application shell.

## Preserved prototype areas

The existing `lib/features/`, `lib/data/`, `lib/routing/`, `supabase/`, and
feature tests predate substantive G1. They are retained as prototype evidence;
their presence is not G1 acceptance and does not authorize G2+ work. G1 did not
delete, restructure, or extend their feature behavior.

No empty `core/shared/features` directory tree was created. The target layout in
`AGENTS.md` is approximate and must be adopted incrementally only when the
corresponding Gate is open.

## G1 architecture decisions

- Riverpod remains the only state-management framework.
- `go_router` remains the only navigation framework.
- `supabase_flutter` is retained as client foundation only; G1 does not
  initialize a schema, implement authentication, or establish authorization.
- Arabic localization support is retained because Arabic and RTL are frozen
  product-quality requirements. This does not add product UI.
- No new dependency was required. Exact resolved versions remain recorded by
  `pubspec.lock` and `G1_DEPENDENCY_MANIFEST.md`.
- Default Flutter debug/profile/release build types remain; product flavors and
  release signing/distribution are not introduced. Signing custody and release
  work remain assigned to G12.

## Safety boundary

OD-012 remains active. G1 uses only the local Flutter project, the isolated
Android emulator, placeholder configuration, and synthetic test values. No
Supabase project, existing database, production environment, migration, reset,
rebuild, or authoritative data was accessed.
