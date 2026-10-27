# Engineering Principles

These principles apply to every project, language, framework, and delivery
environment. Use them as decision criteria, not as a checklist to satisfy
mechanically.

## SOLID

- **Single Responsibility:** A module should have one reason to change.
- **Open/Closed:** Extend behavior without modifying stable code when practical.
- **Liskov Substitution:** Implementations must preserve the contract of the
  abstractions they replace.
- **Interface Segregation:** Prefer focused interfaces over broad contracts
  that force unused dependencies.
- **Dependency Inversion:** High-level policy should depend on abstractions,
  with infrastructure details supplied at the boundary.

## Object-Oriented Design

- Encapsulate state and protect invariants at the object boundary.
- Prefer composition over inheritance unless the subtype relationship is
  genuine and substitutable.
- Keep classes cohesive and collaborators loosely coupled.
- Make invalid states difficult to represent.
- Expose behavior instead of leaking mutable implementation details.

Object-oriented design is one option, not a requirement. Apply the same
principles to functions, modules, services, and data-oriented code.

## Clean Code

- Use names that explain intent.
- Keep functions small, focused, and easy to test.
- Prefer explicit control flow over cleverness.
- Keep side effects at clear boundaries.
- Remove dead code, duplication, and speculative abstractions.
- Treat comments as an explanation of why, not a translation of what.

## Simplicity and Scope

- **KISS:** Choose the simplest design that satisfies the current requirement.
- **YAGNI:** Do not build capabilities without a demonstrated need.
- **DRY:** Consolidate knowledge that must change together. Do not merge code
  merely because it looks similar.
- Prefer a boring, local solution over a framework or abstraction that adds
  more concepts than value.

## Boundaries and Change

- **Separation of Concerns:** Keep domain policy, orchestration, I/O, and
  presentation independently understandable.
- **Law of Demeter:** Talk to immediate collaborators instead of traversing
  object graphs.
- **High cohesion, low coupling:** Keep related decisions together and
  minimize knowledge shared across boundaries.
- **Dependency direction:** Dependencies should point toward stable policy.
- **Design for testability:** Inject time, I/O, randomness, and external
  services at boundaries.

## Reliability and Evolution

- Validate untrusted input at system boundaries.
- Make failures explicit and preserve useful context.
- Prefer deterministic behavior and idempotent operations where possible.
- Optimize only after measuring a real bottleneck.
- Make the smallest change that fully satisfies the requirement, then verify
  behavior with focused checks.

## Review Questions

Before accepting a design or implementation, ask:

1. What is the smallest clear solution?
2. Does each unit have one responsibility and a narrow contract?
3. Are abstractions earning their complexity?
4. Can behavior be tested without real infrastructure?
5. What changes if the requirement evolves?
6. Is duplication accidental, or does it represent independent knowledge?
7. Are errors, security boundaries, and invalid states explicit?
