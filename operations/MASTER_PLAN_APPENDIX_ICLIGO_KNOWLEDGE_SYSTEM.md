# MASTER PLAN APPENDIX: ICLIGO KNOWLEDGE SYSTEM

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-14

---

## 1) Goal

Create a dedicated iCliGo knowledge system for Bubba/Hermes so the agent can operate from a centralized, reusable, and auditable base of truth instead of re-discovering platform behavior on each session.

This knowledge system must cover:
- product documentation
- FAQ
- support content
- authenticated platform guidance
- observed API behavior
- booking flow learning runs
- reservation/agendamento process knowledge

---

## 2) Strategic Decisions

### Dedicated vault
- Use a dedicated Obsidian vault for iCliGo knowledge.
- Do not mix this vault with the current conversational memory vault used for generic Hermes memory.

### Centralized knowledge model
- Keep documentation, FAQ, support, observed endpoints, and E2E booking evidence in the same vault.
- Avoid fragmented sources of truth.

### Hermes usage priority
- Bubba/Hermes should consult the iCliGo vault before improvising answers about:
  - ideas
  - leads
  - bookings
  - booking flow
  - revalidation errors
  - reservation persistence steps

### Evidence-first hierarchy
- Prefer `observed` and `authenticated` knowledge over inferred assumptions.
- Keep origin metadata on every note.

---

## 3) Knowledge Objectives

The system must enable Bubba/Hermes to:
- explain how iCliGo works without fresh re-exploration
- identify which pages and routes matter for each process
- recall observed endpoints and payload structures
- understand booking revalidation behavior
- follow a repeatable reservation playbook
- distinguish documentation truth from runtime-observed truth

---

## 4) Source Classes

Every captured knowledge item must be classified as one of the following:
- `public`
- `authenticated`
- `observed`
- `inferred`

### Definitions
- `public`: accessible without login
- `authenticated`: accessible only with valid iCliGo session/SSO
- `observed`: discovered from browser/network/runtime behavior during real use
- `inferred`: reasoned conclusion not directly stated by the platform

Rule:
- Bubba should prefer `observed` and `authenticated` knowledge for operational actions.

---

## 5) Required Content Domains

The knowledge system must include at minimum:

### Platform domains
- `login.icligo.com`
- `docs.icligo.com`
- `myoffice.icligo.com`
- `travel.icligo.com`
- `api.icligo.com`
- `api.partners.icligo.com`
- `notifications.icligo.com`

### Business/process domains
- authentication and session handling
- MyOffice navigation and route map
- Travel Ideas
- Leads
- Bookings
- booking engine flow
- error states and revalidation
- payment boundary

### Knowledge-source domains
- docs collections
- FAQ
- support content
- observed endpoint catalog
- E2E learning runs

---

## 6) Definition of Done for Knowledge

The iCliGo knowledge system is considered operational when:
- a dedicated vault exists
- the vault contains centralized docs/FAQ/support material
- key platform flows are indexed and linked
- observed API behavior is documented
- booking learning runs are persisted as reusable notes
- Bubba can use the vault as context for operational reasoning

---

## 7) Knowledge Capture Pipeline

### Stage 1: Discovery
- identify platform surface
- identify relevant docs/FAQ/support pages
- identify routes and runtime behaviors

### Stage 2: Extraction
- copy textual knowledge into markdown
- record URLs and auth scope
- capture structured observations from runtime behavior

### Stage 3: Sanitization
- remove credentials
- remove cookies
- remove session tokens
- remove sensitive headers
- remove PII unless explicitly needed and safely handled

### Stage 4: Normalization
- convert material into a stable Obsidian structure
- add metadata and backlinks
- connect docs to flows and endpoints

### Stage 5: Operationalization
- create concise notes that Bubba can use quickly
- connect each process note to the relevant documentation and evidence

### Stage 6: Maintenance
- timestamp validations
- refresh stale notes after real tests
- add new learning runs after each major booking attempt

---

## 8) Sanitization Rules

Never store in the vault:
- passwords
- bearer tokens
- cookies
- raw authenticated headers with reusable secrets
- personal client data unless explicitly required and redacted appropriately

If payloads are stored:
- keep structure
- mask secrets
- mask identity data where not essential to the learning goal

---

## 9) Bubba/Hermes Retrieval Policy

When handling iCliGo-related tasks, Bubba should consult the vault in this order:

1. Index / platform map
2. Booking/agendamento playbook
3. FAQ and support notes
4. Observed API notes
5. E2E learning runs

Operational rule:
- if docs say one thing but observed runtime behavior says another, note the mismatch and prefer the runtime-observed path for execution.

---

## 10) Relationship to the Booking Playbook

This appendix defines the knowledge system.

The actual booking execution playbook is documented separately in:
- `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_BOOKING_AGENDAMENTO.md`

The vault structure and capture rules are documented separately in:
- `/opt/infra/MASTER_PLAN_APPENDIX_ICLIGO_DOCUMENTATION_OBSIDIAN_VAULT.md`

---

## 11) Acceptance Criteria

- Dedicated iCliGo vault path is defined.
- Docs, FAQ, and support are centralized in one vault.
- Observed API and booking evidence are stored with provenance.
- Bubba/Hermes can use the vault as a knowledge base for reservation operations.
- The booking/agendamento playbook and the vault are linked as one coherent system.

---

## 12) Immediate Next Steps

- Create the dedicated vault structure.
- Copy iCliGo docs, FAQ, and support content into the vault.
- Add observed endpoint notes from current authenticated investigation.
- Add E2E learning-run notes from the current booking tests.
- Use the booking/agendamento appendix as the execution playbook for the next live runs.
