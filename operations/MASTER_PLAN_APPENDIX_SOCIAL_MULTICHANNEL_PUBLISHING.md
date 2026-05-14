# MASTER PLAN APPENDIX: SOCIAL MULTICHANNEL PUBLISHING

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-13

---

## 1) Goal

Implement a controlled multichannel social publishing system that can:

- publish one approved content package to multiple social networks
- adapt the same post to each platform without inventing new facts
- generate Instagram Story assets
- generate WhatsApp Status assets
- support temporary promotions with validity windows
- reuse the current WordPress promotions engine as source of truth
- keep approval, audit trail, retries, and scheduling under n8n control

Target runtime model:

`WordPress -> n8n -> optional Hermes adaptation -> channel adapters -> social networks`

---

## 2) Final Planning Decision

Publishing model:

- WordPress-first
- n8n as orchestrator
- Hermes optional for copy adaptation only
- one canonical content package
- multichannel fan-out from one approved source
- temporary promotions inherit validity from WordPress
- stories and status receive dedicated visual assets

This is the best fit for the current Forrest Travels stack because:

- WordPress publishing already exists
- `ft_expiration_date` already exists
- countdown logic already exists on the website
- n8n already exists in production
- Hermes already exists and can adapt text if needed
- this avoids creating a second CMS for social content

---

## 3) Scope

This appendix covers:

- Instagram Feed
- Facebook Page
- LinkedIn Page
- Instagram Story
- WhatsApp Status
- content normalization
- temporary promotion rules
- scheduling
- approval workflow
- asset generation
- audit trail
- retries and failure handling

This appendix does not yet implement:

- TikTok publishing
- X/Twitter publishing
- Pinterest publishing
- comments/replies automation
- inbound DM automation
- social listening
- analytics dashboard
- ad campaign management
- carousel automation
- short-form video automation

---

## 4) Current Infrastructure Alignment

## Already present
- WordPress website in production
- Promotions engine in WordPress with `ft_expiration_date`
- Countdown UI already implemented on WordPress
- n8n in production
- Hermes in production
- audit-log pattern already used in Hermes ops modules
- Traefik routing
- Uptime Kuma monitoring

## Already present and relevant
- WordPress controlled publishing path
- n8n governance path
- ability to create/update WordPress posts safely
- roadmap note that social profile scraping remains deferred

## Missing
- multichannel social publishing workflows
- social credential storage pattern
- canonical social content package
- story/status asset derivative pipeline
- channel adapters
- scheduling and approval policy for social distribution
- per-channel audit trail
- failure isolation and retry workflow
- monitoring for multichannel publishing failures

---

## 5) WordPress-First Source of Truth

## Core rule
WordPress is the primary source of publishable content.

## Content origin modes
Priority order:

1. WordPress post/page approved for social distribution
2. manual n8n intake for short promotional content in a future phase
3. future CRM/content calendar source

## Release 1 decision
Only WordPress-first is in scope.

This means:

- content is created or approved in WordPress first
- social distribution uses the WordPress content and metadata
- temporary promotions inherit validity from WordPress metadata
- no independent social-only content authoring pipeline in release 1

---

## 6) Promotion and Validity Rules

## Source of truth for temporary promotions
For promotional content, validity comes from WordPress:

- `ft_expiration_date` is the primary expiration source
- promotional state comes from the post configuration
- countdown on site remains real and dynamic on WordPress

## Countdown rule by channel
### WordPress
- use real countdown already implemented
- keep expired state visible
- keep expired CTA behavior already implemented

### Social feed posts
Static social posts do not support a real dynamic countdown in normal feed content.

Therefore:
- if platform supports scheduling within the valid period, use it
- if platform supports an end-of-publication rule, use it
- if platform does not support expiration, include explicit validity text
- always include availability disclaimer for promotional content

### Stories and Status
Stories/Status may include:
- urgency text
- visual expiration date
- limited-time messaging
- countdown-style visual language

But unless connector/platform supports actual dynamic countdown behavior:
- treat it as a visual urgency asset, not a true live timer

## Mandatory social disclaimer for promotional content
If a post is promotional and time-limited, every social publication must include a validity statement and availability disclaimer.

Standard long form:

`Promocao valida ate [data/hora]. Sujeito a disponibilidade, alteracao tarifaria e confirmacao no momento da reserva. Apos esse periodo, pode nao haver mais vagas, passagens ou a mesma condicao comercial.`

Standard short form for Story/Status:

`Valido ate [data]. Sujeito a disponibilidade. Depois desse periodo, a oferta pode nao estar mais disponivel.`

## Expired behavior for social
Because social feed posts often remain visible after publication:

- social posts remain as historical content unless platform supports removal or archival
- validity must be explicit in the caption
- future automation may post a follow-up or mark campaign expired internally
- no promise of post auto-removal in release 1

---

## 7) Canonical Content Package

Every social publication starts from one canonical package.

## Required fields
- `content_id`
- `source_type`
- `source_ref`
- `title`
- `long_caption`
- `short_caption`
- `cta_text`
- `destination_url`
- `campaign_tag`
- `publish_mode`
- `channels`
- `hero_image_url`
- `hero_image_path`
- `story_image_url`
- `story_image_path`
- `hashtags`
- `scheduled_at`
- `approved_by`
- `trace_id`

## Promotion-specific required fields
- `is_promotional`
- `offer_start_at`
- `offer_end_at`
- `countdown_enabled`
- `availability_disclaimer`
- `inventory_disclaimer`
- `price_disclaimer`
- `expired_behavior`
- `story_countdown_text`
- `status_countdown_text`

## Optional fields
- `price_text`
- `locale`
- `brand_variant`
- `offer_label`
- `vertical_asset_pack_id`
- `link_in_bio_target`
- `notes_for_operator`

## Rules
- promotion validity may never be invented by Hermes
- if `is_promotional=true`, then `offer_end_at` is required
- if `is_promotional=true`, then disclaimer text is required
- if Story or Status is selected, a vertical asset path is required before publish approval

---

## 8) Channel Adaptation Layer

The same message should not be copied blindly to every network.

## General rule
Use the canonical package as fact source and adapt tone/length per platform.

## Instagram Feed
- short-to-medium caption
- visual-first framing
- stronger emotional CTA
- hashtags allowed
- include validity text when promotional

## Facebook Page
- medium caption
- more explanatory copy
- direct booking/contact context
- include validity and disclaimer when promotional

## LinkedIn Page
- more structured and professional tone
- less emoji-heavy
- trust, planning, concierge angle
- include validity text if promotional, adapted to platform tone

## Instagram Story
- vertical visual
- minimal text
- urgency text if promotional
- use date or `ate DD/MM` overlay
- use static visual urgency if live countdown is not automatable

## WhatsApp Status
- vertical visual
- short text
- immediate urgency if promotional
- include simplified disclaimer
- must remain separated from private Bubba chat channel credentials/flows

## Hermes role
Hermes may:
- shorten captions
- adapt tone
- create short hooks
- create Story overlay text
- create Status overlay text

Hermes may not:
- invent new prices
- invent new expiration dates
- invent availability
- change destination facts without approved source

---

## 9) Media and Asset Strategy

## Feed assets
Initial support:
- single image post

Future support:
- carousel
- video

## Story/Status assets
Need dedicated vertical derivatives.

### Target format
- 9:16
- mobile-first
- readable text safe zones
- brand-safe overlay positioning
- compressed for platform upload

## Asset sources
1. provided vertical creative
2. auto-generated vertical derivative from hero image
3. future AI-assisted derivative generation

## Required derivative outputs
- feed-ready image
- story-ready vertical image
- status-ready vertical image

## Promotional overlay logic
If promotional:
- add urgency-safe visual text
- add explicit end date or short validity message
- avoid fake real-time countdown visuals unless explicitly static and clear

Examples:
- `So ate 25/05`
- `Ultimos dias`
- `Valido ate domingo`
- `Promocao por tempo limitado`

---

## 10) Workflow Topology in n8n

Recommended split:

## Workflow A: `social_content_package_builder`
Purpose:
- ingest WordPress content
- read post title/body/excerpt/media/meta
- detect promotion metadata
- build canonical package
- store package for review

## Workflow B: `social_asset_derivatives`
Purpose:
- create feed derivative if needed
- create Story asset
- create WhatsApp Status asset
- apply overlay rules
- store final asset references

## Workflow C: `social_approval_router`
Purpose:
- receive explicit approval
- validate channels
- validate promotional requirements
- validate asset readiness
- lock schedule and channels

## Workflow D: `social_publish_fanout`
Purpose:
- publish to each selected channel independently
- isolate errors by channel
- write per-channel audit entries

## Workflow E: `social_retry_recovery`
Purpose:
- retry failed publications
- avoid duplicates where possible
- escalate repeated failures

## Workflow F: `social_audit_summary`
Purpose:
- build operator-facing summary
- show success/failure per channel
- log final campaign state

---

## 11) Approval Policy

No multichannel publish should occur without explicit approval.

## Approval modes
- draft only
- approved immediate publish
- approved scheduled publish

## Required approval gates
- content approved
- channels approved
- media approved
- schedule approved
- promotion metadata approved if promotional
- disclaimer approved if promotional

## Blocking rules
A promotional post may not be approved for social if:
- `ft_expiration_date` is missing
- `offer_end_at` is missing in canonical package
- disclaimer text is missing
- selected Story/Status channels have no vertical asset
- validity text is missing from adaptation plan

---

## 12) Scheduling Strategy

n8n owns scheduling and fan-out.

## Modes
- immediate publish
- scheduled publish
- partial channel scheduling
- retry-only publish for failed channels

## Promotion scheduling rules
- if promotional, publication must occur inside the validity window
- if a channel supports expiration/end scheduling, use it
- if not, include validity text in copy
- do not schedule first publication after the promotion end time

## Required metadata
- `scheduled_at`
- `timezone`
- `offer_end_at`
- `channel_publish_state`
- `retry_count`
- `last_error`
- `published_at`
- `response_ref`

---

## 13) Channel Connector Strategy

## Preferred model
Use stable/official publication paths where possible, with n8n orchestrating all calls.

## Channel groups
- Meta publication layer:
  - Instagram Feed
  - Facebook Page
  - Instagram Story
- LinkedIn publication layer
- WhatsApp Status publication layer

## Important separation
WhatsApp Status and private Bubba WhatsApp chat must be treated as separate concerns.

### Rule
- do not couple private Bubba messaging workflow and Status publication workflow by default
- credentials, workflow path, and audit trail should be separable
- Status publishing must not interfere with private chat session reliability

---

## 14) Audit Trail

A dedicated multichannel audit stream is required.

## Audit fields
- `timestamp`
- `trace_id`
- `content_id`
- `source_type`
- `source_ref`
- `channel`
- `action`
- `status`
- `scheduled_at`
- `published_at`
- `asset_pack_id`
- `promotion_state`
- `offer_end_at`
- `response_ref`
- `error`

## Events to log
- canonical package created
- asset derivative created
- approval granted
- approval blocked
- scheduled publish created
- per-channel publish started
- per-channel publish success
- per-channel publish failure
- retry triggered
- promotion-expired publish prevented
- story/status asset generated
- manual operator correction

---

## 15) Failure Handling

## Failure classes
- connector auth failure
- asset generation failure
- media upload failure
- API publish failure
- schedule failure
- duplicate ambiguity
- publish attempted after expiration
- partial fan-out failure

## Required behavior
- one failed channel does not erase successful channels
- each channel is logged independently
- retries must be controlled
- operator receives failure summary
- promotional content cannot publish as active after expiration

## Retry rules
- retry transient connector/network errors
- do not blindly retry duplicate/validation errors
- do not retry if promotional validity window has already expired

---

## 16) Monitoring

Must monitor:

- package build failures
- asset generation failures
- channel publish failures
- repeated retry exhaustion
- approval queue backlog
- invalid promotional package attempts

## Monitoring targets
- n8n workflow failures
- connector health where measurable
- scheduling backlog
- audit anomaly counts

## Acceptance criteria
- no silent channel failure
- no silent post-expiration promotional publish
- repeated connector failures become visible quickly

---

## 17) Security and Credential Handling

This appendix must follow the security hardening appendix.

## Rules
- no social connector secret hardcoded in compose files
- credentials stored in restricted env files or equivalent
- separate credentials per platform
- separate WhatsApp Status credentials/flow from private Bubba chat if both exist
- no secret leakage into logs
- workflow exports should avoid secret sprawl

## Checklist
- [ ] define per-platform credential inventory
- [ ] store platform credentials outside compose
- [ ] mask secrets in audit and workflow logs
- [ ] define credential rotation path
- [ ] define least-privilege ownership per connector

---

## 18) Release 1 Scope

Included:
- WordPress-first source
- canonical content package
- promotional metadata handling
- Instagram Feed
- Facebook Page
- LinkedIn Page
- Instagram Story asset generation path
- WhatsApp Status asset generation path
- approval gate
- scheduling support
- audit trail
- failure isolation

Excluded:
- TikTok
- Pinterest
- X/Twitter
- reply/comment automation
- inbound social DM automation
- social listening
- advanced analytics dashboard
- carousel automation
- automatic video generation

---

## 19) Detailed Technical Checklist

## Phase 1: Canonical schema
- [ ] define canonical social package schema
- [ ] define promotion-specific required fields
- [ ] define validation rules
- [ ] define blocked states for invalid promotional packages

## Phase 2: WordPress acquisition
- [ ] define how WordPress marks content for social distribution
- [ ] define which fields are pulled from WordPress
- [ ] map `ft_expiration_date` to `offer_end_at`
- [ ] map promotional state to `is_promotional`

## Phase 3: Asset pipeline
- [ ] define hero image requirements
- [ ] define feed derivative rules
- [ ] define Story derivative rules
- [ ] define WhatsApp Status derivative rules
- [ ] define overlay rules for promotions
- [ ] define storage location for generated assets

## Phase 4: Copy adaptation
- [ ] define per-channel copy rules
- [ ] define Hermes adaptation boundaries
- [ ] define mandatory promotional disclaimer injection
- [ ] define short-form versions for Story and Status

## Phase 5: Approval router
- [ ] define approval event format
- [ ] define schedule format
- [ ] define channel locking behavior
- [ ] define promotional validation gate before approval

## Phase 6: Channel publication
- [ ] define Instagram Feed adapter
- [ ] define Facebook Page adapter
- [ ] define LinkedIn adapter
- [ ] define Instagram Story publication path
- [ ] define WhatsApp Status publication path
- [ ] define per-channel response logging

## Phase 7: Failure handling
- [ ] define retry policy by channel
- [ ] define non-retryable errors
- [ ] define duplicate prevention strategy
- [ ] define expired-promotion blocking behavior

## Phase 8: Monitoring and audit
- [ ] define audit schema
- [ ] define operator summary
- [ ] define monitoring alerts
- [ ] define publish health indicators

---

## 20) Acceptance Test Matrix

## Canonical package
- [ ] one WordPress post becomes one canonical social package
- [ ] promotional WordPress post carries `offer_end_at`
- [ ] missing promotion validity blocks approval

## Feed channels
- [ ] Instagram Feed variant generated and published
- [ ] Facebook variant generated and published
- [ ] LinkedIn variant generated and published
- [ ] each channel logged separately

## Story and Status
- [ ] Instagram Story asset generated from canonical package
- [ ] WhatsApp Status asset generated from canonical package
- [ ] Story asset contains urgency/validity when promotional
- [ ] Status asset contains urgency/validity when promotional

## Promotions
- [ ] promotional copy includes explicit validity
- [ ] promotional copy includes availability disclaimer
- [ ] no first publication is allowed after `offer_end_at`
- [ ] expired promotions are not distributed as active offers

## Operations
- [ ] approval is required before multichannel publish
- [ ] scheduled publish works
- [ ] partial channel failure does not hide successful channels
- [ ] retries are controlled and logged

## Security
- [ ] no social credentials hardcoded in compose
- [ ] credentials are platform-separated
- [ ] WhatsApp Status path does not interfere with private Bubba chat path
- [ ] logs do not expose platform tokens

---

## 21) Deferred Items

Not part of this first plan:
- short promo-only content source directly in n8n
- comments/replies automation
- inbound DM workflows
- social listening
- campaign analytics dashboard
- AI-generated visual campaign packs by default
- TikTok/X/Pinterest expansion

---

## 22) Final First Implementation Path

Recommended first implementation path:

`WordPress post -> n8n canonical package -> promotion validation -> optional Hermes adaptation -> Instagram/Facebook/LinkedIn publish + Story/Status derivative generation -> audit`

This keeps the social system aligned with the current Forrest Travels infrastructure and ensures that temporary promotions stay consistent with the website countdown and validity model.
