# ACS — App Capability Snapshot

> **ACS** = App Capability Snapshot. This file describes what **I Can Read** can do **right now** — present tense, not roadmap. Update it after every meaningful feature change.

**Code layout**: Documentation-only repository at present: `PRD.md` (product requirements), `ARCHITECTURE.md` (implementation architecture), `ACS.md` (current capability snapshot), `LICENSE`.

**Version label**: `2026.05.06-docs.1` — single source `ACS.md` (until code implementation introduces a dedicated version file); bump on each feature ship.

---

## Problem We Solve

I Can Read currently defines a child-focused guided read-aloud experience for early readers (around age 7) with parent support, including short phonics/sight-word practice sessions, warm corrective feedback, and parent-visible progress and override controls at the product-definition level. Today, the app exists as a detailed specification set (not yet a deployed runtime), and those specifications already encode how reading attempts, feedback tone, mastery tracking, and voice output expectations should work.

---

## Platform

- **Deployment target**: Not yet deployed (planned web-first MVP per architecture document)
- **Primary browsers / runtimes**: Not applicable in current build (no runnable client yet)
- **Install / distribution**: Not applicable in current build
- **Rate limiting**: Not implemented in current build; API boundaries are documented but no active server is running
- **Environment notes**: Repository is doc-first; no env vars required to read/edit docs

---

## Auth

- **Sign-in methods**: Not implemented in current build
- **Token model**: Not implemented in current build
- **Session persistence**: Not implemented in current build
- **Auth errors**: Not implemented in current build

---

## Product Definition (PRD)

- Defines the complete intended reading-session loop: warm-up, story round, spotlight, and recap.
- Specifies speech evaluation behavior with uncertainty handling and explicit parent override requirements.
- Defines voice delivery quality bar: natural, warm, human-like output, low-cost model preference, and text fallback behavior.

---

## System Design (Architecture)

- Defines modular architecture components (session engine, recognition adapter, evaluation, feedback, mastery, rewards, progress).
- Establishes local-first MVP data strategy and core conceptual entities (`ChildProfile`, `WordRecord`, `SessionRecord`, etc.).
- Documents teacher voice adapter design and current MVP model recommendation (`gpt-4o-mini-tts`) for low-cost natural playback.

---

## Realtime

- **Protocol**: Not implemented in current build
- **Events**: Conceptual event log documented (`session_started`, `attempt_evaluated`, etc.), but no live transport exists yet
- **Reconnect behavior**: Not implemented in current build
- **Multi-replica notes**: Not implemented in current build

---

## API Surface (summary)

| Endpoint | Role |
|----------|------|
| `POST /api/speech/recognize` | Planned recognition adapter endpoint for sentence-level speech-to-text |
| `POST /api/feedback/generate` | Planned constrained feedback generation endpoint |
| `GET /api/content/stories` | Planned curated micro-story retrieval endpoint |
| `POST /api/sync/push` | Planned optional cloud sync push endpoint |
| `GET /api/sync/pull` | Planned optional cloud sync pull endpoint |

See [ARCHITECTURE.md](ARCHITECTURE.md) for the canonical table.

---

## Database (conceptual)

- **ChildProfile** — child identity/preferences fields used to personalize sessions and pacing.
- **WordRecord** — per-word attempt counts and mastery progression (`new`, `practicing`, `strong`).
- **Story / StorySentence / SentenceWord** — curated reading content plus phonics/sight-word metadata.
- **SessionRecord** — per-session timing, rewards, practiced words/stories, and parent overrides.
- **ParentOverride** — correction records that supersede uncertain or incorrect recognition outcomes for mastery.

---

## Out of Scope (current build)

- Runnable client UI and microphone capture implementation (currently specified only).
- Active speech recognition provider integration and production API hosting.
- Authentication, account system, and cloud multi-device sync runtime.
- Operational rate limiting, telemetry pipelines, and deployment infrastructure.

---

## Version Display

- **Location**: Displayed in this document header as the active snapshot version (no app UI exists yet)
- **Current**: `2026.05.06-docs.1` (see `ACS.md`)
