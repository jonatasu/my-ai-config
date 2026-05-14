# MASTER PLAN APPENDIX: WHATSAPP PRIVATE CHANNEL

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-13

---

## 1) Goal

Implement a private WhatsApp channel for Bubba with this runtime path:

`WhatsApp -> Evolution Go -> n8n -> Hermes -> n8n -> Evolution Go -> WhatsApp`

Constraints:
- VPS-only cost model
- No paid WhatsApp gateway
- Keep Hermes provider as current `copilot`
- Private channel only
- Strict whitelist for authorized users
- Low operational complexity
- Minimal token waste

---

## 2) Final Technical Decisions

### Channel scope
- Private channel only
- Exactly authorized numbers may interact with Bubba
- No public rollout in this phase
- No group support in this phase

### WhatsApp gateway
- Use `Evolution Go`
- Do not use classic `Evolution API + Redis`
- Do not use Meta official API in this phase
- Do not use UAZAPI/Z-API in this phase

### Runtime orchestration
- `n8n` is the middleware/security boundary
- `Hermes` remains the intelligence layer
- `Traefik` publishes the gateway route
- `Uptime Kuma` monitors the gateway

### Hermes invocation strategy
- Use a lightweight internal webhook/bridge for `n8n -> Hermes`
- Do not use per-message shell command execution as the primary integration path

Reason:
- same token cost
- lower per-message process overhead
- cleaner timeout handling
- cleaner auditability
- easier future extension to media/audio

---

## 3) Current State vs Missing Pieces

### Already present
- `Traefik`
- `n8n`
- `Hermes`
- `Twenty`
- `WordPress`
- `Uptime Kuma`
- `Hermes` running with:
  - `HERMES_INFERENCE_PROVIDER=copilot`
  - `HERMES_MODEL=gpt-4o`

### Missing
- WhatsApp gateway stack
- WhatsApp route in Traefik
- Paired WhatsApp instance
- n8n inbound workflow
- n8n outbound workflow
- normalized payload contract
- Hermes WhatsApp guard env vars
- audit log for WhatsApp
- health monitors for WhatsApp gateway
- message buffer
- human handoff pause
- audio/media pipeline

---

## 4) File and Service Targets

### New stack directory
- `/opt/infra/whatsapp`

### Expected stack files
- `/opt/infra/whatsapp/docker-compose.yml`
- `/opt/infra/whatsapp/.env`
- `/opt/infra/whatsapp/data/` or equivalent persistent volume path

### Existing files to update later
- `/opt/infra/MASTER_PLAN.md`
- `/opt/infra/hermes/docker-compose.yml`
- `/opt/infra/traefik/docker-compose.yml` only if needed by routing strategy
- n8n workflow data/configuration inside `/opt/infra/n8n/data`

### New monitoring target
- Uptime Kuma monitor for WhatsApp gateway
- Optional webhook readiness monitor

---

## 5) Phase-by-Phase Checklist

## Phase 1: WhatsApp Gateway Stack

### Deliverables
- Create `/opt/infra/whatsapp`
- Add `Evolution Go` stack
- Add persistent session storage
- Attach to Docker networks:
  - `web`
  - `internal`
- Configure restart policy
- Configure healthcheck
- Configure secure gateway credentials

### Acceptance criteria
- Container starts successfully
- Gateway is reachable internally
- Gateway survives restart
- Persistent session volume is mounted

### Checklist
- [ ] Create stack directory `/opt/infra/whatsapp`
- [ ] Create compose for `Evolution Go`
- [ ] Create env file for gateway secrets
- [ ] Attach `web` network
- [ ] Attach `internal` network
- [ ] Add persistent storage for session/state
- [ ] Add restart policy
- [ ] Add healthcheck

---

## Phase 2: Public Routing via Traefik

### Deliverables
- Publish gateway under `whatsapp.forresttravel.cc`
- TLS enabled via existing Traefik resolver
- Minimal exposure of admin/manager endpoints

### Acceptance criteria
- HTTPS route works
- Manager endpoint is reachable for setup
- API/webhook endpoint is reachable by n8n

### Checklist
- [ ] Decide exact public route: `whatsapp.forresttravel.cc`
- [ ] Add Traefik labels to gateway stack
- [ ] Confirm target service port
- [ ] Confirm TLS certificate issuance
- [ ] Confirm route works externally
- [ ] Confirm route works from n8n usage path

---

## Phase 3: Pairing and Session Persistence

### Deliverables
- Create WhatsApp instance
- Pair via QR code
- Validate reconnect persistence

### Acceptance criteria
- WhatsApp account is connected
- Restart of container does not require new QR
- Instance reports connected state after restart

### Checklist
- [ ] Open manager
- [ ] Create instance
- [ ] Pair via QR code
- [ ] Send manual test message to paired number
- [ ] Restart gateway container
- [ ] Validate session persistence
- [ ] Validate instance remains connected

---

## Phase 4: Canonical Payload Contract

### Goal
Define one normalized contract between gateway, n8n, and Hermes.

### Canonical fields
- `provider`
- `instanceId`
- `sender`
- `pushName`
- `fromMe`
- `chatType`
- `messageType`
- `text`
- `messageId`
- `quotedMessageId`
- `timestamp`
- `mediaUrl`
- `mediaMimeType`
- `traceId`

### Acceptance criteria
- All inbound messages normalize into same schema
- Hermes never depends on raw Evolution payload format

### Checklist
- [ ] Define normalized payload format
- [ ] Map gateway webhook fields to canonical schema
- [ ] Generate `traceId` for every inbound interaction
- [ ] Define outbound payload contract from Hermes back to n8n

---

## Phase 5: n8n Inbound Workflow

### Workflow name
- `wa_inbound_bubba`

### Required flow
1. Receive webhook from gateway
2. Normalize payload
3. Ignore `fromMe=true`
4. Ignore group chats
5. Enforce whitelist
6. Buffer fragmented messages
7. Check handoff pause state
8. Call Hermes bridge
9. Prepare outbound response
10. Call outbound sender step
11. Write audit trail

### Acceptance criteria
- Authorized sender is processed
- Unauthorized sender is ignored and logged
- Bot never loops on its own outgoing messages

### Checklist
- [ ] Create inbound webhook node
- [ ] Add normalization node
- [ ] Add `fromMe` filter
- [ ] Add group filter
- [ ] Add whitelist filter
- [ ] Add trace ID generation
- [ ] Add audit entry for unauthorized attempts
- [ ] Add Hermes call step
- [ ] Add outbound step handoff
- [ ] Add success/failure audit entries

---

## Phase 6: Whitelist and Private Access Control

### Required policy
- Only explicit authorized numbers may interact
- Numbers stored in canonical format
- Enforced in both n8n and Hermes

### New Hermes env vars
- `WHATSAPP_ALLOWED_USERS=...`

### Acceptance criteria
- Authorized user A can interact
- Authorized user B can interact
- Unauthorized number gets no reply
- Unauthorized attempt is logged

### Checklist
- [ ] Define authorized numbers list
- [ ] Store list in canonical E.164-style format without formatting noise
- [ ] Implement whitelist check in n8n
- [ ] Add `WHATSAPP_ALLOWED_USERS` in Hermes env
- [ ] Implement redundant guard in Hermes bridge

---

## Phase 7: Hermes Internal Bridge

### Decision
Implement a lightweight internal HTTP bridge for `n8n -> Hermes`.

### Minimal contract
Input:
- canonical payload
- sender
- text
- message type
- trace ID

Output:
- reply text
- optional response type
- optional metadata
- status/error

### Requirements
- synchronous request/response
- controlled timeout
- low overhead
- structured error responses
- internal-only exposure preferred

### Acceptance criteria
- n8n can call Hermes through a stable interface
- Hermes returns structured response
- timeout and failure cases are explicit

### Checklist
- [ ] Define bridge endpoint path
- [ ] Define bridge input schema
- [ ] Define bridge output schema
- [ ] Set timeout policy
- [ ] Add internal auth or origin restriction if needed
- [ ] Add structured error handling
- [ ] Add trace ID propagation into logs

---

## Phase 8: n8n Outbound Workflow/Step

### Goal
Send Hermes response back through Evolution Go.

### Initial scope
- text only

### Later scope
- image
- audio
- document

### Acceptance criteria
- reply is delivered to the original sender
- send failures are logged
- retry behavior is controlled

### Checklist
- [ ] Define outbound HTTP request to gateway
- [ ] Map recipient from canonical sender field
- [ ] Map reply text from Hermes output
- [ ] Add small send delay if desirable
- [ ] Add success log
- [ ] Add failure log
- [ ] Add retry policy for transient errors

---

## Phase 9: Message Buffer for Fragmented Messages

### Goal
Merge consecutive short user messages into one prompt.

### Initial strategy
- wait window: `5-10s`
- same sender
- same chat
- same active interaction window

### Acceptance criteria
- multiple quick fragments become a single Hermes request
- no duplicate fragmented replies

### Checklist
- [ ] Define buffer window
- [ ] Define per-sender key
- [ ] Store pending fragments
- [ ] Merge fragments into single text block
- [ ] Emit one normalized request to Hermes
- [ ] Clear buffer after send

---

## Phase 10: Human Handoff Pause

### Goal
Pause Bubba when a human takes over.

### Initial strategy
- detect manual operator response
- pause bot for configured duration
- allow explicit resume command

### Suggested defaults
- pause duration: 2 hours
- resume command: internal control flag or specific command

### Acceptance criteria
- human can intervene without bot competing
- pause state is per chat/user
- resume path is explicit

### Checklist
- [ ] Define pause trigger
- [ ] Define pause storage/state
- [ ] Define pause duration
- [ ] Define resume mechanism
- [ ] Ensure paused chat does not call Hermes
- [ ] Log pause/resume events

---

## Phase 11: Audit Trail

### Goal
Add dedicated WhatsApp audit trail.

### Suggested log fields
- `timestamp`
- `traceId`
- `provider`
- `sender`
- `authorized`
- `messageType`
- `action`
- `status`
- `error`

### Events to log
- inbound received
- unauthorized blocked
- fromMe ignored
- group ignored
- buffered
- sent to Hermes
- Hermes timeout
- outbound success
- outbound failure
- pause triggered
- pause resumed

### Acceptance criteria
- every inbound interaction is traceable
- every outbound attempt is traceable
- failures are diagnosable

### Checklist
- [ ] Define audit log location
- [ ] Define audit event schema
- [ ] Write inbound audit entries
- [ ] Write outbound audit entries
- [ ] Write failure audit entries
- [ ] Write security rejection audit entries

---

## Phase 12: Monitoring

### Goal
Add visibility in Uptime Kuma.

### Monitors
- gateway health endpoint
- optional manager reachability
- optional webhook readiness
- optional paired-session health indicator

### Acceptance criteria
- gateway downtime is visible
- degraded path can be identified quickly

### Checklist
- [ ] Add gateway health monitor
- [ ] Add route monitor for `whatsapp.forresttravel.cc`
- [ ] Add optional webhook readiness monitor
- [ ] Define alert threshold
- [ ] Validate monitor shows healthy state

---

## Phase 13: Media and Audio Expansion

### First production scope
- text only

### Next steps
- audio inbound transcription
- image inbound handling
- document inbound handling
- media outbound

### Acceptance criteria for future media phase
- audio can be converted to text before Hermes call
- image/document events are detected and routed correctly

### Checklist
- [ ] Add audio route design
- [ ] Add image route design
- [ ] Add document route design
- [ ] Define media storage policy if gateway links expire
- [ ] Define fallback reply when media parsing is unavailable

---

## Phase 14: Security Hardening

### Goal
Reduce avoidable exposure.

### Required improvements
- move gateway secrets out of compose body into `.env` or equivalent
- use least-privilege credentials
- restrict admin/manager exposure where possible
- preserve session data securely
- avoid broad public exposure of control endpoints

### Acceptance criteria
- secrets are not hardcoded in compose
- manager exposure is limited
- backup and restart behavior are defined

### Checklist
- [ ] Store gateway secrets outside compose body
- [ ] Limit exposed endpoints
- [ ] Define backup path for session persistence
- [ ] Define restore procedure
- [ ] Define restart validation steps

---

## 6) Execution Order

### Order of implementation
- [ ] Create `/opt/infra/whatsapp`
- [ ] Add `Evolution Go` stack
- [ ] Publish via `Traefik`
- [ ] Pair WhatsApp instance
- [ ] Validate session persistence
- [ ] Define canonical payload contract
- [ ] Build inbound n8n workflow
- [ ] Build Hermes internal bridge
- [ ] Build outbound n8n step/workflow
- [ ] Add whitelist in n8n
- [ ] Add whitelist in Hermes
- [ ] Add fragmented-message buffer
- [ ] Add human handoff pause
- [ ] Add audit trail
- [ ] Add Uptime Kuma monitor
- [ ] Run end-to-end text tests
- [ ] Expand to audio/media later

---

## 7) Acceptance Test Matrix

### Security
- [ ] Authorized user A -> reply received
- [ ] Authorized user B -> reply received
- [ ] Unauthorized user -> no reply
- [ ] Unauthorized attempt -> audit log entry exists

### Reliability
- [ ] Gateway restart -> session preserved
- [ ] n8n restart -> flow recovers
- [ ] Hermes timeout -> graceful fallback path
- [ ] Outbound gateway error -> retry/log path works

### Bot behavior
- [ ] `fromMe=true` does not re-trigger loop
- [ ] Group messages are ignored
- [ ] Fragmented messages are merged
- [ ] Human handoff pause blocks bot reply
- [ ] Resume path restores bot reply

### Observability
- [ ] Trace ID visible through inbound and outbound logs
- [ ] Uptime monitor shows healthy
- [ ] Gateway failure is visible

---

## 8) Deferred Items

Not part of first implementation:
- multi-provider failover
- UAZAPI/Z-API support
- Meta official API support
- public/support-wide WhatsApp rollout
- group-chat automation
- mass outbound campaigns
- rich media outbound as first release

---

## 9) Final First-Release Scope

### Included in release 1
- private channel only
- Evolution Go
- text messages only
- strict whitelist
- normalized inbound payload
- n8n security boundary
- Hermes bridge
- outbound text reply
- audit trail
- health monitoring
- message buffer
- human handoff pause

### Excluded from release 1
- audio
- image understanding
- documents
- multi-provider fallback
- public rollout
