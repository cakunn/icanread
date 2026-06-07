# Agent Working Agreement

## Required Context

Read `ACS.md`, `PRD.md`, `ARCHITECTURE.md`, and `DESIGN.md` before changing
application behavior. `ACS.md` is the authoritative snapshot of what the latest
verified build can actually do.

## Definition of Done

After every completed, verified capability or coherent build session:

1. Add a concise entry under `CHANGELOG.md` → `Unreleased`.
2. Update `ACS.md` so it describes the latest runnable state.
3. Update `PRD.md`, `ARCHITECTURE.md`, or `DESIGN.md` when product behavior,
   scope, architecture, or design rules changed.
4. Record verification performed and unresolved limitations.
5. Do not describe planned, mocked, partially implemented, or unverified
   behavior as an available capability.

A build increment is incomplete until code, tests, `CHANGELOG.md`, `ACS.md`, and
all affected product documentation agree.

## Engineering Rules

- Preserve the frontend, application, domain, and infrastructure boundaries in
  `ARCHITECTURE.md`.
- The frontend must not connect directly to Postgres, object storage, or AI
  providers.
- Learning and mastery rules belong to deterministic domain code.
- Keep child mode unable to reach account, consent, approval, export, deletion,
  or purchase controls without a parental gate.
- Never expose draft or non-expert-reviewed curriculum as approved instruction.
- Treat uncertain speech recognition as unscored, not incorrect.
