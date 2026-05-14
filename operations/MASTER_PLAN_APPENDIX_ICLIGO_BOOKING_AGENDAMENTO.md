# MASTER PLAN APPENDIX: ICLIGO BOOKING / AGENDAMENTO

Domain: forresttravel.cc
VPS: Hetzner CX32 (95.217.212.33)
Updated: 2026-05-14

---

## 1) Goal

Define the operational playbook to execute an iCliGo reservation up to the point where the platform accepts `Salvar`, `Guardar`, or `Reservar`, and the remaining gap is payment only.

---

## 2) Definition of Result (DoR)

This process reaches DoR when the platform accepts one of the reservation-persistence actions:
- `Salvar`
- `Guardar`
- `Reservar`

The intended post-DoR state is:
- reservation/idea persisted in the platform
- booking flow advanced as far as allowed without financial submission
- payment still pending

---

## 3) Reference Learning Scenario

The current E2E learning fixture is:
- route: `Lisboa -> Roma -> Lisboa`
- dates: `03/10/2026 -> 10/10/2026`
- occupancy: `2 adults + 1 child`
- child age: `5`

Important rule:
- this is a learning scenario only
- it must not be treated as the generic booking model for the system

Operational model must remain dynamic:
- adults
- children
- child ages
- rooms
- route
- dates

---

## 4) Confirmed Runtime Behavior

The iCliGo booking engine revalidates inventory during the flow.

Observed behavior already confirmed:
- search can create a valid trip
- availability page can load a concrete package
- summary page can show package total and deferred-payment split
- first confirmation can trigger a revalidation modal
- the system may report that the last seats were taken by another consultant
- repricing or package change can happen without ending the flow

Operational conclusion:
- revalidation must be treated as expected runtime behavior, not as a terminal failure

---

## 5) Flow Map

Expected runtime flow:

1. authenticated session
2. `operators-booking/search-box`
3. search submit
4. `vmashAvailability.xhtml?tripId=...`
5. `summary.xhtml?tripId=...`
6. revalidation loop if needed
7. `Salvar` / `Guardar` / `Reservar`
8. passenger completion if required
9. payment screen
10. stop before payment execution

---

## 6) Success Criteria

The run is successful when:
- a valid `tripId` is created
- the package remains operational after revalidation
- `Salvar` / `Guardar` / `Reservar` is accepted
- passenger data is accepted if the flow requires it
- the remaining missing action is payment

---

## 7) Execution Phases

## Phase 1: Session and Search

Goal:
- establish a valid session and create a trip

Steps:
- ensure login/session state is valid
- open the booking search box
- fill route, dates, occupancy, and child ages
- submit the search
- capture resulting query and `tripId`

Evidence to keep:
- search URL/query
- JSF submit payload shape
- resulting `tripId`

---

## Phase 2: Availability Review

Goal:
- confirm that the returned package still matches the intended scenario

Validate:
- route coherence
- dates
- occupancy
- flight pair
- hotel selection
- total price / price per person

If the package is coherent:
- proceed to summary

---

## Phase 3: Summary and Revalidation Loop

Goal:
- survive inventory rechecks and converge on a stable bookable package

When the system shows a revalidation/inventory-loss modal:
- close or acknowledge the modal
- read the updated price/package
- confirm whether the scenario is still acceptable
- retry confirmation if acceptable

Automatic acceptance criteria:
- same city pair
- same dates
- same occupancy
- still operationally valid package

Escalation criteria:
- route degradation
- dates changed unexpectedly
- materially worse package
- unacceptable price deviation

---

## Phase 4: Persistence Action

Goal:
- reach DoR by making the platform accept reservation persistence

Action priority:
- identify whether the active persistence step is exposed as `Salvar`, `Guardar`, or `Reservar`
- execute the action that persists the reservation/idea

Evidence that DoR was reached can include:
- visual confirmation
- state transition
- persistent booking reference
- preserved trip in later step
- booking/idea appearing in the expected system path

---

## Phase 5: Passenger Completion

Goal:
- provide all data required to keep the booking moving without paying yet

Likely required data:
- full names
- birth dates
- nationality
- document type and number
- document validity
- title/contact details of the holder
- email
- address or tax fields if required

Success condition:
- the platform accepts the passenger step without a blocking validation error

---

## Phase 6: Payment Boundary

Goal:
- stop exactly before irreversible financial action

Allowed:
- load payment page
- inspect totals and due-now split
- confirm that booking data persisted

Not allowed unless explicitly requested:
- pay
- confirm charge
- execute financial authorization
- finalize payment

---

## 8) Operational Rules

### Rule: Do not confuse learning fixture with system model
- `2 adults + 1 child age 5` is the current test case only

### Rule: Revalidation is normal
- price and package changes between summary attempts are expected

### Rule: Payment is the hard stop
- the process should continue until only payment remains, then stop

### Rule: Preserve evidence
- each run should leave enough evidence to improve the next run

---

## 9) Minimum Data Model for Automation

- `session_valid`
- `trip_id`
- `route`
- `departure_date`
- `arrival_date`
- `occupancy_adults`
- `occupancy_children`
- `occupancy_child_ages`
- `rooms`
- `selected_outbound`
- `selected_hotel`
- `selected_return`
- `price_per_person`
- `total_price`
- `deposit_now`
- `remaining_later`
- `revalidation_count`
- `persist_action`
- `booking_state`
- `passenger_state`
- `payment_state`

---

## 10) Expected Internal States

- `session_ready`
- `search_submitted`
- `trip_created`
- `offer_loaded`
- `summary_loaded`
- `revalidation_required`
- `offer_repriced`
- `offer_persisted`
- `passengers_pending`
- `passengers_completed`
- `payment_pending`

---

## 11) Adapter-Oriented View

### Hermes responsibilities
- own browser/session state
- execute DOM/JSF interactions
- detect revalidation and repricing
- capture evidence

### n8n responsibilities
- orchestrate workflow state
- persist run logs
- add retries and human checkpoints
- trigger Hermes actions in controlled sequence

---

## 12) Acceptance Criteria

- The playbook can be followed from search to payment boundary.
- Revalidation is treated as an expected branch.
- DoR is clearly defined as successful acceptance of `Salvar` / `Guardar` / `Reservar`.
- The hard stop before payment is explicit.

---

## 13) Immediate Next Steps

- Re-run the booking flow with the child age fixed at `5`.
- Use the current revalidation knowledge instead of treating inventory-loss modal as terminal.
- Continue until the persistence action is accepted.
- Document the resulting state in the iCliGo vault as a new learning run.
