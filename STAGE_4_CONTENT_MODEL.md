# Stage 4 Content Model

Status: **IMPLEMENTED — AWAITING OWNER CLOSURE**
Authority: owner instruction `STAGE 4 — DHIKR, WIRD & ASSIGNMENT EXECUTION`
Baseline: `d51f2e28c40e41c422199f9242fccdd1ea9a88d3`

## Dhikr definition

`dhikr_definitions` is organization-owned reusable content. A branch-created
draft carries `owner_branch_id`; this prevents a branch manager from editing
another branch's draft. Approved content is available to authorized managers
inside the organization but is never globally visible.

Lifecycle: `draft → in_review → approved → archived`. Rework from
`in_review → draft` and controlled restoration `archived → draft` are allowed.
Approval requires an organization administrator, a source reference, reviewer,
and review timestamp. Content changes increment `content_version`; a SHA-256
checksum identifies the stored version.

## Wird

`wirds` references an approved dhikr in the same organization and stores title,
description, target, absolute validity instants, owner branch where applicable,
creator, and lifecycle. Target is constrained to `1..100000`; `end_at` must be
later than `start_at`.

Lifecycle: `draft → scheduled → active → ended/cancelled`. `ended` and
`cancelled` are terminal. New rows begin only as `draft` or `scheduled`.

Management creation accepts organization-local start/end dates. PostgreSQL
converts them to absolute instants using `organizations.timezone`; the end date
is inclusive and becomes the exclusive start of the following local day.
Retrieval uses server `now()`, never device time as authority.

## Historical content

Materialized user instances copy the wird title, dhikr title/text, target,
window, timezone and assignment source. Editing either source record does not
rewrite a prior instance. Instance update/delete is blocked by a database
trigger; assignment revocation retains history.

No counter, progress, local persistence, sync, reward, campaign, or reporting
model was introduced in Stage 4.
