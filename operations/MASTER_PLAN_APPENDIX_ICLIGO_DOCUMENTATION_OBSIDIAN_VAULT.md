# MASTER PLAN APPENDIX: ICLIGO DOCUMENTATION OBSIDIAN VAULT

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-14

---

## 1) Goal

Create a dedicated Obsidian vault that centralizes all relevant iCliGo knowledge for Bubba/Hermes, including documentation, FAQ, support material, observed API behavior, and E2E learning runs.

---

## 2) Vault Decision

### Vault model
- Use a dedicated iCliGo vault.
- Keep this vault separate from the current Hermes conversational memory vault.

### Proposed vault path
- `/opt/data/obsidian_icligo`

### Intended role
- operational knowledge base for Bubba/Hermes
- research and troubleshooting base for iCliGo
- documentation source for future automation adapters

---

## 3) Centralization Rule

The following content must live together in this vault:
- docs
- FAQ
- support material
- authenticated platform notes
- observed endpoints
- booking-engine findings
- E2E learning runs

Do not split FAQ/support into a separate source of truth.

---

## 4) Required Source Coverage

### Documentation and support surfaces
- `docs.icligo.com`
- FAQ content inside the iCliGo platform
- support collections/pages available through docs or platform UI
- consultant support resources
- finance/support collections relevant to booking flow

### Product/runtime surfaces
- `login.icligo.com`
- `myoffice.icligo.com`
- `travel.icligo.com`
- `api.icligo.com`
- `api.partners.icligo.com`
- `notifications.icligo.com`

### Observed runtime sources
- browser network requests
- modal/error states
- route changes
- booking-engine forms
- JSF payload patterns

---

## 5) Vault Structure

- `00 Index`
- `01 Platform Overview`
- `02 Authentication and Session`
- `03 MyOffice`
- `04 Travel Ideas`
- `05 Leads`
- `06 Bookings`
- `07 Booking Engine`
- `08 Observed API`
- `09 FAQ and Support`
- `10 Error States and Revalidation`
- `11 E2E Learning Runs`
- `12 Automation Design`
- `13 Open Questions`

---

## 6) Content Types

Each knowledge item should be captured as one of the following:

### Mirror note
- near-faithful copy of source content
- preserves wording, URL, and source context

### Operational note
- concise interpretation for execution
- explains when and why the content matters

### Evidence note
- runtime-discovered behavior
- captures observed routes, endpoints, payloads, and errors

### Learning-run note
- captures a real E2E attempt
- records outcome, blocker, and next step

---

## 7) Mandatory Metadata

Every note should include at minimum:
- `title`
- `source_url`
- `auth_scope`
- `source_type`
- `service`
- `last_validated`
- `confidence`
- `related_flow_step`

Additional fields when applicable:
- `category`
- `related_endpoints`
- `observed_in_route`
- `trip_context`

---

## 8) FAQ and Support Capture Policy

The full iCliGo FAQ must be copied into the vault.

For each FAQ/support item:
- preserve question and answer
- preserve source URL
- preserve category/collection if visible
- store auth scope
- create backlinks to relevant operational notes when useful

Recommended pattern:
- one mirror note for the original content
- one operational note when the item has booking relevance

---

## 9) Observed API Capture Policy

For each observed endpoint, record:
- method
- URL pattern
- auth requirement
- where it was observed
- request parameters or payload shape
- response shape summary
- operational significance

If storing examples:
- sanitize secrets
- sanitize personal data
- keep the structure needed for learning and automation design

---

## 10) Booking Evidence Capture Policy

For each significant booking attempt, store:
- search scenario
- route and dates
- occupancy and child ages
- query parameters
- JSF payload observations
- `tripId`
- selected package snapshot
- repricing/revalidation behavior
- modal or error text
- whether `Salvar` / `Guardar` / `Reservar` was accepted

---

## 11) Suggested Note Templates

### Template: Mirror note
- Title
- Source URL
- Auth scope
- Category
- Captured on
- Original content

### Template: Operational note
- Purpose
- When to use
- Key takeaways
- Related flow step
- Related endpoints
- Links to source notes

### Template: Learning run
- Scenario
- Inputs
- Observed route sequence
- Observed API calls
- Outcome
- Blocker
- Next attempt recommendation

---

## 12) Initial Population Priorities

1. Platform map and index
2. Auth/session notes
3. FAQ and support
4. MyOffice routes
5. Ideas, leads, and bookings notes
6. Booking engine and revalidation notes
7. Observed API catalog
8. E2E learning runs

---

## 13) Acceptance Criteria

- Dedicated vault path is created.
- FAQ and support are centralized in the vault.
- Main docs and authenticated collections are mirrored.
- Observed endpoints are documented with provenance.
- E2E learning runs are documented and linked.
- Bubba/Hermes can use the vault as a practical knowledge base.

---

## 14) Follow-on Work

- Optional private Git sync for the dedicated iCliGo vault.
- Add lightweight search/index strategy if recall volume grows.
- Link the vault to future Hermes adapter endpoints once automation begins.
