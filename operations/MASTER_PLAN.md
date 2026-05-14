# MASTER PLAN: FORREST TRAVELS ECOSYSTEM
Domain: forresttravel.cc | VPS: Hetzner CX32 (95.217.212.33) | Ubuntu 24.04
Updated: 2026-05-14

---

## 1) Current Architecture

- Reverse Proxy: Traefik v2.11 (`/opt/infra/traefik`)
- Website + CMS: WordPress (`forresttravel.cc`)
- Automation: n8n (`flow.forresttravel.cc`)
- AI Operations Agent: Hermes/Bubba (container `hermes`, TUI mode)
- CRM: Twenty (`crm.forresttravel.cc`) + Postgres + Redis
- Monitoring: Uptime Kuma (`status.forresttravel.cc/status/dashboard`)
- AI Workspace: Open WebUI (`brain.forresttravel.cc`)

Docker structure: `/opt/infra/{traefik,n8n,hermes,twenty,db,monitoring,backups,brain,wordpress}`
Networks: `web` (public via Traefik) + private/internal networks.

---

## 2) Delivered in This Cycle

### Frontend / WordPress
- Mobile top menu stabilized and made accessible:
  - Toggle upgraded to semantic `button`
  - `aria-expanded`, `aria-label`, `aria-controls`, `aria-hidden`
  - Escape to close, focus return, outside-click close
  - Theme click-handler conflicts neutralized
  - Close icon made clearly visible (same button, icon swap open/close)
- Visual and accessibility refinements:
  - Fixed empty icon-only links (logo/share/author cases)
  - Heading hierarchy normalized on blog (duplicate H1 removed in rendered DOM)
  - Contrast improvements for interactive elements

### Promotions Engine (WordPress)
- New post meta `ft_expiration_date` controls promotional expiry.
- Auction-style countdown UI on cards/posts (Days/Hours/Min/Sec).
- Expired state keeps post visible (does not hide):
  - Expired badge + visual state
  - WhatsApp CTA message auto-changes to “promotion ended but quote for another date”.
- Admin usability:
  - Added post metabox with instructions + datetime input
  - Safe save with nonce/capability/autosave guards

### Monitoring
- Uptime Kuma public status page configured and populated:
  - URL: `https://status.forresttravel.cc/status/dashboard`
  - Group: `Core Services`
  - Monitors: Website Forrest, N8N Flow, CRM Twenty, Brain AI, Status Uptime
  - Current status: all UP in latest heartbeats

### Data/ops note
- `ft_expiration_date` test values were configured for active/expired scenario validation.

---

## 3) Master Backlog (Existing)

- Cloudflare Email Routing for `contato@forresttravel.cc` (receive flow)
- SMTP “sending” configuration for branded outbound email (deferred)
- Replace queue-based `.ndjson` persistence with direct Twenty API upserts
- Finalize real WhatsApp ingestion binding to Hermes webhook
- Trend scouting and approval-to-publish pipeline hardening

---

## 4) NEW Strategic Items (Requested)

### 4.1 Bubba -> n8n full flow governance
Allow Bubba (Hermes) to access n8n and:
- create, edit, delete workflows
- publish/import workflow definitions
- activate/deactivate workflows
- run/test workflows when requested

Implementation status (2026-05-12):
- DONE: operational bridge deployed at /opt/infra/hermes/ops/n8n_flow_manager.py
- DONE: helper wrapper /opt/infra/hermes/ops/bubba_n8n.sh
- DONE: audit trail in /opt/infra/hermes/ops/n8n_flow_audit.ndjson
- DONE: env wired into Hermes (N8N_API_URL, N8N_API_KEY)
- VALIDATED: list, deactivate, activate commands against production n8n
- NOTE: publish endpoint is not available on current n8n build (returns 404)

Implementation direction:
- add optional workflow JSON schema validation for create/update
- add explicit approval gate for delete in chat-facing commands

### 4.2 Bubba -> WordPress admin publishing operations
Allow Bubba to publish/edit content in WordPress directly or by triggering n8n flow when requested.

Implementation direction:
- WP Application Password (least privilege user)
- safe posting pipeline (draft-first optional)
- route option A: direct WP REST API
- route option B: call secured n8n publishing workflow

### 4.3 Bubba -> Twenty CRM + database insights
Allow Bubba to read CRM data and relevant DB context to generate customer insights and campaign opportunities.

Implementation status (2026-05-12):
- DONE: DB-backed insights module deployed:
  - /opt/infra/hermes/ops/twenty_insights_manager.py
  - /opt/infra/hermes/ops/bubba_twenty.sh
  - /opt/infra/hermes/ops/README_TWENTY_AUTONOMY.md
  - audit log /opt/infra/hermes/ops/twenty_insights_audit.ndjson
- DONE: Hermes env wired for Twenty DB connectivity (TWENTY_DB_*).
- DONE: baseline insight commands validated (overview, ull-report).
- IMPORTANT: current Twenty instance has zero users/workspaces/channels (fresh core schema), so reports currently return readiness recommendations.
- IMPORTANT: fixed Twenty storage permission issue (/opt/infra/twenty/data/storage now writable by uid/gid 1000).

Implementation direction:
- add API-token based Twenty GraphQL integration once auth bootstrap is completed
- add lead/contact/opportunity metrics queries after workspace/object data exists
- strict data governance, redaction, and role boundaries

### 4.4 Bubba memory persistence (Obsidian + private storage)
Allow Bubba to save structured memory in Obsidian format and persist to private DB or private GitHub repository.

Implementation status (2026-05-12):
- DONE: Obsidian memory manager deployed:
  - /opt/infra/hermes/ops/obsidian_memory_manager.py
  - /opt/infra/hermes/ops/bubba_memory.sh
  - /opt/infra/hermes/ops/README_OBSIDIAN_AUTONOMY.md
  - audit log /opt/infra/hermes/ops/obsidian_memory_audit.ndjson
- DONE: Hermes env wired for memory module:
  - OBSIDIAN_VAULT_PATH=/opt/data/obsidian
  - MEMORY_REPO_URL=git@github.com:jonatasu/hermes_memory_forrest_travel.git
  - MEMORY_REPO_BRANCH=main
- VALIDATED: note and decision writes persisted to vault and audit log.
- DONE: private GitHub sync is operational (first commit `76aa127` on `main`).
- DONE: idle-triggered sync automation deployed:
  - `/opt/infra/hermes/ops/hermes_idle_memory_sync.sh`
  - cron schedule `*/5 * * * *` with 30-minute inactivity gate before sync execution
  - state tracking in `/opt/infra/hermes/ops/.idle_memory_sync_state`
  - log in `/opt/infra/hermes/ops/idle_memory_sync.log`
- DONE: contextual memory recall command deployed:
  - `bubba_memory.sh recall --query ... --limit ... [--category ...]`
  - implementation in `/opt/infra/hermes/ops/obsidian_memory_manager.py`
  - relevance ranking by keyword overlap + recency, with compact excerpts
- DONE: Bubba policy updated in `/opt/infra/hermes/data/SOUL.md` to use memory only when relevant (no forced greeting/announcement behavior).

Implementation direction:
- add log rotation/retention for idle sync logs
- tune recall scoring (domain/category weighting, minimum score threshold)
- optional DB mirror of high-priority memories

### 4.5 OpenCode VPS memory sync of this session
Transfer detailed session memory and decisions into VPS operational memory and master plan.

Status:
- This item is now executed in this update (master plan and memory files refreshed).

### 4.6 Bubba <-> WhatsApp private channel (Evolution Go)
Goal: enable Bubba conversations on WhatsApp with the same interaction model as Telegram, restricted to exactly two authorized users.

Decision:
- Chosen stack: Evolution Go (`WhatsApp -> Evolution Go -> n8n -> Hermes -> n8n -> Evolution Go -> WhatsApp`).
- Why this replaced the earlier Evolution API direction: lower stack complexity for VPS-only operation, no added Redis requirement for the gateway layer, and better fit for the current cost constraint while preserving webhook-based n8n orchestration.
- See detailed appendix: `/opt/infra/MASTER_PLAN_APPENDIX_WHATSAPP_PRIVATE_CHANNEL.md`

Implementation plan:
1) Infrastructure and routing
- Deploy Evolution Go as a dedicated service under `/opt/infra/whatsapp` with persistent session volume.
- Attach service to Docker networks `web` and `internal`.
- Expose through Traefik at `https://whatsapp.forresttravel.cc`.
- Protect API access with strong global key and internal service token boundaries.

2) n8n orchestration (security boundary)
- Create inbound workflow `wa_inbound_bubba` receiving Evolution Go webhook events.
- Normalize sender payload to canonical phone format (E.164 without formatting ambiguity).
- Enforce strict whitelist gate (allow only the two approved numbers).
- Drop/ignore unauthorized senders and log attempted access.
- Forward authorized text payloads to Hermes gateway and await response.
- Create outbound workflow step to send Hermes response back to original WhatsApp sender via Evolution Go.

3) Hermes integration adjustments
- Add redundant guard env var `WHATSAPP_ALLOWED_USERS` in Hermes runtime.
- Update Bubba policy to support WhatsApp as an additional channel while preserving persona and existing guardrails.
- Keep channel behavior consistent with Telegram (no auto-posting without explicit approval where required).

4) Reliability and observability
- Add audit log stream for WhatsApp ingress/egress with timestamp, sender, status, and trace id.
- Add health monitor in Uptime Kuma for Evolution Go endpoint and webhook readiness.
- Define restart-safe pairing/session persistence strategy to avoid QR loss.

5) Validation checklist
- Authorized user A -> message -> Bubba reply (PASS)
- Authorized user B -> message -> Bubba reply (PASS)
- Unauthorized number -> no reply + access denied log (PASS)
- Restart Evolution Go container -> session remains connected without re-pairing (PASS)
- n8n/Hermes degraded path -> graceful failure message + audit entry (PASS)

6) Rollout sequence
- Phase 1: deploy Evolution Go + Traefik route + QR pairing.
- Phase 2: wire n8n inbound/outbound workflows with whitelist enforcement.
- Phase 3: enable Hermes guard var + final policy sync.
- Phase 4: run end-to-end tests and monitor for 24h before broad use.

### 4.7 Bubba <-> iCliGo knowledge system and booking playbook
Goal: convert iCliGo documentation, FAQ, support knowledge, observed endpoints, and real booking-learning runs into a dedicated Obsidian knowledge base for Bubba/Hermes, plus an execution playbook for reservation scheduling up to the point where only payment remains.

Decisions:
- Use a dedicated Obsidian vault for iCliGo knowledge, separate from the current Hermes conversational memory vault.
- Centralize docs, FAQ, support, observed API behavior, booking flow notes, and E2E evidence in one place.
- Treat the booking learning scenario (`Lisboa -> Roma -> Lisboa`, `2 adults + 1 child age 5`) as a reference scenario only, not as a fixed system rule.
- Use `Salvar` / `Guardar` / `Reservar` acceptance as the booking-process Definition of Result (DoR).
- After the DoR is reached, the intended remaining gap is payment only.

Detailed appendices:
- Knowledge system governance:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_KNOWLEDGE_SYSTEM.md`
- Dedicated Obsidian vault structure and documentation capture:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_DOCUMENTATION_OBSIDIAN_VAULT.md`
- Reservation scheduling / booking execution playbook:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_BOOKING_AGENDAMENTO.md`

---

## 5) Security and Governance Rules for Autonomous Bubba

- Least privilege first for every integration credential.
- Separate credentials by domain: n8n, WordPress, Twenty, GitHub.
- Mandatory audit trail for create/edit/delete/activate/deactivate actions.
- “High impact actions” require explicit user intent phrase before execution.
- Backup/rollback required before bulk edits in CMS/CRM/workflows.

---

## 6) Current Operational Status Snapshot

- Website: operational
- n8n: operational
- Twenty CRM: operational
- Hermes: operational (TUI mode)
- Brain/Open WebUI: operational
- Uptime Kuma dashboard: operational and populated

---

## 6.1) Planning Appendices

- WhatsApp private channel implementation appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_WHATSAPP_PRIVATE_CHANNEL.md`
- Security risk and secret hygiene hardening appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_SECURITY_SECRET_HARDENING.md`
- Social multichannel publishing appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_SOCIAL_MULTICHANNEL_PUBLISHING.md`
- iCliGo knowledge system appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_KNOWLEDGE_SYSTEM.md`
- iCliGo dedicated Obsidian vault appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_DOCUMENTATION_OBSIDIAN_VAULT.md`
- iCliGo booking/agendamento appendix:
  - `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_BOOKING_AGENDAMENTO.md`

---

## 7) Next Execution Block (Priority Order)

1. Build the dedicated iCliGo knowledge vault for Bubba/Hermes (docs, FAQ, support, observed API, booking evidence)
2. Execute the iCliGo booking/agendamento learning playbook until `Salvar` / `Guardar` / `Reservar` is accepted and only payment remains
3. Implement Bubba <-> WhatsApp private channel using Evolution Go (2-user whitelist, n8n bridge, Hermes guardrails)
4. Execute first-pass secret hygiene hardening and credential rotation plan
5. Design and implement WordPress-first multichannel social publishing with Story/Status derivatives and promotional validity rules
6. Add log rotation/retention for memory sync and WhatsApp audit logs
7. Populate Twenty baseline data and evolve insights from readiness mode to business metrics
8. Configure Cloudflare email receiving + later SMTP sending capability


## UPDATE 2026-05-12 01:23Z
- Obsidian memory private sync is now operational.
- Command validated: /opt/ops/bubba_memory.sh sync-github
- Remote repo: jonatasu/hermes_memory_forrest_travel
- Branch: main
- First sync commit: 76aa127

## UPDATE 2026-05-12 01:50Z
- Deployed inactivity-based memory sync automation:
  - Cron runs every 5 minutes, but sync executes only after >=30 minutes without new Hermes session activity.
  - New interactions within the 30-minute window postpone sync.
- Added memory recall capability for contextual retrieval from Obsidian vault:
  - `/opt/ops/bubba_memory.sh recall --query "..." --limit 5`
  - Supports multi-word queries and returns ranked relevant notes/excerpts.
- Updated Bubba prompt policy to consult memory only when it improves the requested task.

## UPDATE 2026-05-12 02:10Z
- Approved next major initiative: private WhatsApp channel for Bubba.
- Evolution Go selected as the current implementation target for the VPS-only cost model, replacing the earlier Evolution API direction.
- Detailed implementation plan moved to appendix `/opt/infra/MASTER_PLAN_APPENDIX_WHATSAPP_PRIVATE_CHANNEL.md`.
- Security risk and secret hygiene hardening plan documented in appendix `/opt/infra/MASTER_PLAN_APPENDIX_SECURITY_SECRET_HARDENING.md`.

## UPDATE 2026-05-13 14:00Z
- Added detailed appendix for WordPress-first multichannel social publishing:
  - `/opt/infra/MASTER_PLAN_APPENDIX_SOCIAL_MULTICHANNEL_PUBLISHING.md`
- Decision recorded: temporary promotions in social channels must inherit validity from WordPress `ft_expiration_date`.
- Rule recorded: social feed posts must include explicit validity/disclaimer text when dynamic expiration is not supported by the platform.
- Stories and WhatsApp Status require dedicated vertical derivatives and urgency-safe promotional overlays when applicable.

## UPDATE 2026-05-14 00:00Z
- Added iCliGo knowledge-system appendix to define how Bubba/Hermes should consume centralized iCliGo knowledge.
- Added dedicated Obsidian vault appendix for iCliGo documentation, FAQ, support content, observed API behavior, and learning runs.
- Added iCliGo booking/agendamento appendix with a reservation playbook up to the point where only payment should remain.
- Decision recorded: FAQ and support content must be copied into the same centralized iCliGo vault, not split across separate repositories of truth.
- Decision recorded: the current `2 adults + 1 child age 5` flow is a learning fixture only and must not be treated as the generic booking model.

## UPDATE 2026-05-14 01:00Z
- Bubba morning routine was consolidated back into the Hermes runtime as the canonical user-facing delivery path.
- Trend scouting schedule was aligned to `08:00` Europe/Lisbon and now runs inside the `hermes` container.
- User-facing morning delivery remains at `10:00` and now includes live-enriched price references for flights, stays, and experiences, with source links.
- Generic n8n trend digests are no longer the canonical morning message and should remain internal-only if reused later.
- `/opt/infra/hermes/ops/README_DESTINATION_INTEL.md` was aligned with the production cron/runtime model.
