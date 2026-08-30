# G0 Frozen Baseline — Rawdat Wird

Frozen baseline identifier: `RW-G0-FROZEN-001`  
Owner gate decision: `GD-G0-FINAL`  
Frozen on: 2026-08-30  
State: `G0 = APPROVED / CLOSED / FROZEN`

## 1. Authority

This manifest is the formal G0 baseline authorized by the Human Owner. It freezes the product boundary, roles/scopes, child-authentication policy, logical data model, offline-sync behavior, platform, gate contracts, document authority, final blocker disposition, and OD-012 safety constraint.

G1 and later work must conform to this baseline. Historical/prototype documents cannot override it.

## 2. Frozen decisions

- OD-001–OD-013 are resolved as recorded in `OWNER_DECISION_REGISTER.md`.
- `branch_manager` is limited to exactly one organization and one branch and has no sibling-branch or organization-wide authority.
- `PRODUCTION DATA ABSENCE = NOT VERIFIED`; destructive reset/rebuild/overwrite/delete and empty-state assumptions are prohibited against existing or unknown state.
- Android is the MVP release platform; G12 requires a signed installable APK.
- The G0-GC-01 artifact set contains 11 artifacts.
- Deferred decisions remain mandatory at their assigned Gates; deferral is not omission.

## 3. Frozen artifact manifest

SHA-256 values identify the exact content frozen by `GD-G0-FINAL`. A changed hash requires an approved change-control record and a new baseline version unless the change is demonstrably non-substantive and recorded as such.

| Artifact | SHA-256 |
|---|---|
| `G0_FINAL_GATE_DECISION.md` | `825a4fa0b329b98a66c9cc061f9f78f511ab8209cc0b5d0dbbd20914293d2172` |
| `OWNER_DECISION_REGISTER.md` | `a480aacfc4a2ab087abca8f6f7b786b904d9eab8d3dc62c22bf7fa81cfac7678` |
| `MVP_SCOPE_BASELINE.md` | `9a9eeb179034c28f9a315b74258183e7efaab961f6ea40cdd2be16ba1f0e922a` |
| `ROLE_AND_SCOPE_MODEL.md` | `ff68ae8ce3a22aba0f7665ed0e3beb1d10aa5c8888c93253e00c460137563ba3` |
| `STUDENT_AUTH_POLICY.md` | `33d9569a0a2a4a7a455e5961eeb45ab2449721444c0dec72b97b74c17dfaf07b` |
| `LOGICAL_DATA_MODEL.md` | `0141c1429866989c7960e1caf2dbf3915ebee41c69f819e7c2fc86c560a7b895` |
| `OFFLINE_SYNC_CONTRACT.md` | `641e1301365ee26649776c11b4310abaf95de2a68c097e1b898b459a99aab0ac` |
| `PLATFORM_BASELINE.md` | `c4fae7750449205285cf10b9cac65d32fbfb283a198893d2033e234e9da4d512` |
| `GATE_ACCEPTANCE_MATRIX.md` | `9f89b33c480a3d61d7638d1643d27369f33517e163fc99ae9aa90a1e736decb6` |
| `DOCUMENT_AUTHORITY_MAP.md` | `4d45713b3c58757d0bc705713899486838162f93b0f1df41f0e584089b1932fd` |
| `G0_FINAL_BLOCKER_STATUS.md` | `518b65016702b4be2afa98084165fcf79868f86132397090c0cedd02dc55d09f` |
| `G0_FINAL_VERIFICATION.md` | `15e520858ec824eed53cbfc914f6e65303f4c8001a0558a67062417f91517d28` |
| `G0_DOCUMENT_CONSISTENCY_AUDIT.md` | `d7c33abf5a2e6c559719c9d0b1e08f6e2ec21e15a76c911053959ab4f9b4a603` |
| `G0_OWNER_DECISION_STATUS.md` | `5f0eb67c30612e059d2fd93fa3b28403742ba824c7d0749ebfc0fdb70df84597` |
| `OD002_ROLE_RECONCILIATION.md` | `d26088f8139fc6a6f4213cf0f114b6f3fa2a3b4cdbad8f41839be6cf7803c1a1` |
| `OD012_PRODUCTION_DATA_VERIFICATION.md` | `0d676f8325774f0aab40faf23a625a33ba93d664c74ac0bf4400ec4bfdb248ad` |
| `OD013_ARTIFACT_COUNT_CORRECTION.md` | `5749f77938f0a0edb2628f8e239b65a7cd381bad56f715c30f3d7da9bedfdd81` |

`G0_FROZEN_BASELINE.md` is the manifest itself and is identified by the baseline ID rather than a self-referential hash.

## 4. Continuing safety constraint

OD-012 applies to every later Gate. New local/test files, isolated environments, and synthetic data are permitted only in the Gate that authorizes them and only when they cannot affect potentially authoritative state. Discovery of a real or possibly authoritative environment stops destructive work and requires an explicit migration/change-control decision.

## 5. Deferred decision assignments

| Decision/detail | Assigned Gate | Requirement before Gate exit |
|---|---|---|
| OD-014: Flutter/Dart/package/application identifiers and Android minimums | G1 | resolve the subset required for foundation before substantive G1 work/exiting G1 |
| OD-025: device floor and release custody/distribution details | G1/G12 | device floor before G1 verification; signing/distribution before G12 |
| Child PIN/lockout/session technical parameters | G3 | approve and test before G3 exit |
| Offline grace-window duration | G7 | approve and test late-event behavior before G7 exit |
| Final numerical point values | G9 | approve data-driven values and tests before G9 exit |
| Exact retention periods | G11 | approve before G11 exit/production |
| Remaining OD-014–OD-026 items | Assigned Gates in the register | explicit resolution before corresponding exit |

## 6. Change-control mechanism

A substantive baseline change must include:

1. unique change ID;
2. requested change and rationale;
3. affected OD/G0 artifacts and downstream Gates;
4. security, privacy, schema, offline, release, and data-migration impact as applicable;
5. explicit Human Owner decision;
6. updated documents and verification evidence;
7. a new baseline ID/version and refreshed hashes.

No agent may silently alter the frozen substance. Typographical/non-substantive corrections must still be recorded and must not change meaning.

## 7. Gate state at freeze

`G0 = APPROVED / CLOSED / FROZEN`  
`G1 = OPEN`  
`G2–G12 = NOT OPENED`
