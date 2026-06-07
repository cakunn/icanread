# I Can Read - MVP Architecture

## 1. Architecture Goals

The architecture prioritizes:

- Fast delivery of a polished native iPhone and iPad MVP.
- Reliable low-latency voice interaction.
- Deterministic, auditable learning decisions.
- Strict separation between approved curriculum and generative AI.
- Child privacy, parent control, and deletion by design.
- A clean path from one child to a commercial multi-family service.
- Low operational complexity and bounded AI cost.

## 2. Recommended Stack

### Apple Client

- **Swift 6 and SwiftUI**
- **iOS/iPadOS 17+**
- Swift Concurrency for networking and audio pipelines.
- AVFoundation for recording, playback, and parent-created audio.
- PencilKit or SwiftUI Canvas for tracing.
- StoreKit 2 reserved for future subscriptions; no child-mode purchases.
- XCTest and XCUITest for unit, integration, and UI tests.

A native client gives the best control over child-friendly touch interactions,
audio sessions, microphone interruptions, accessibility, and iPad layouts. A
shared SwiftUI codebase covers both target devices.

### Backend

Use **Supabase** as the managed application backend:

- Postgres for curriculum, profiles, attempts, mastery, and approvals.
- Supabase Auth for parent authentication.
- Row Level Security for household isolation.
- Private object storage for approved retained audio and story assets.
- Edge Functions for privileged APIs, AI orchestration, and signed media access.
- Database migrations kept in the repository.

Use provider-neutral interfaces for:

- Speech-to-text and constrained pronunciation evidence.
- Text-to-speech.
- Bounded conversational responses.
- Story generation and safety checks.

The first implementation can use a single cloud AI provider behind server-side
adapters. Provider credentials must never ship in the app.

### Observability

- Privacy-filtered structured server logs.
- Crash and performance reporting configured to exclude child text and audio.
- Product events sent through a typed analytics interface.
- Server-side AI usage, latency, error, and estimated cost records.

Before selecting commercial SDKs, verify their child-directed-service terms and
disable advertising identifiers, profiling, and session replay.

## 3. System Separation

The product is divided into independently owned layers. Each layer exposes a
small contract and depends only on layers below it.

| Layer | Owns | Must Not Own |
| --- | --- | --- |
| Apple frontend | Rendering, touch and audio capture, local UI state, accessibility, cached session playback | Mastery decisions, provider credentials, database access, story safety policy |
| Backend API | Authentication, authorization, request validation, orchestration, public contracts | SwiftUI state, provider-specific UI behavior |
| Learning domain | Curriculum rules, session planning, evidence evaluation, mastery, hint progression | HTTP, SQL, Supabase SDKs, AI SDKs, visual presentation |
| Content domain | Curated content, story lifecycle, decodability validation, parent approval | Child-facing rendering, direct AI-provider calls |
| AI integration | STT, TTS, conversation, generation, safety-provider adapters and cost enforcement | Curriculum sequencing, mastery, authorization |
| Data layer | Persistence, migrations, RLS, object storage, repository implementations | Pedagogical decisions or UI behavior |
| Operations | Deployment, observability, alerts, audit, deletion workers | Raw child content in general telemetry |

### Dependency Direction

```text
Frontend UI
    -> Frontend application/use cases
        -> Frontend domain models and repository protocols
            -> API and local-cache adapters

Backend transport/API
    -> Backend application/use cases
        -> Learning and content domains
            -> Repository and provider protocols
                -> Postgres, storage, and AI adapters
```

Dependencies point inward toward domain rules. Domain modules define interfaces;
infrastructure modules implement them.

- The frontend never connects directly to Postgres, storage, or an AI provider.
- The frontend never computes authoritative mastery or reward eligibility.
- Backend route handlers validate and delegate; they contain no pedagogy.
- The learning domain has no dependency on Supabase, HTTP frameworks, or AI.
- AI adapters return evidence or candidate content; domain services decide what
  that evidence means.
- Database triggers enforce integrity and audit constraints, not lesson flow.
- Shared API schemas contain transport types, not view models or SQL rows.

### Deployment Units

The MVP has four deployable units:

1. **iOS/iPadOS app:** Child mode, parent mode, audio capture, and local cache.
2. **Backend functions/API:** Application use cases and privileged workflows.
3. **Supabase platform:** Auth, Postgres, RLS, and private object storage.
4. **Background workers:** Story generation, narration, export, and deletion.

Edge Functions can host both API and worker handlers initially. Their code
remains separated by module so long-running workers can move to a dedicated
runtime without changing public APIs or domain rules.

## 4. High-Level Design

```text
┌──────────────────────── iPhone / iPad App ────────────────────────┐
│ Parent Mode                      Child Mode                        │
│ onboarding, consent, dashboard   session player, stories, rewards │
│ story approval, data controls    touch + microphone + speaker     │
│                                                                   │
│ Presentation -> App Use Cases -> Repository Protocols -> Adapters │
└──────────────────────────────┬────────────────────────────────────┘
                               │ TLS + short-lived auth token
┌──────────────────────────────▼────────────────────────────────────┐
│ Transport / API: auth, validation, versioned request contracts    │
├───────────────────────────────────────────────────────────────────┤
│ Application: sessions, stories, rewards, data-control use cases   │
├───────────────────────────────────────────────────────────────────┤
│ Domain: curriculum, evidence, mastery, approval and reward rules  │
├───────────────────────────────────────────────────────────────────┤
│ Infrastructure: repositories, storage, AI and telemetry adapters  │
└─────────────┬────────────────────┬────────────────────┬───────────┘
              │                    │                    │
        ┌─────▼─────┐       ┌──────▼──────┐      ┌─────▼─────────┐
        │ Postgres  │       │ Object Store│      │ AI Providers  │
        │ + RLS     │       │ private     │      │ STT/TTS/LLM   │
        └───────────┘       └─────────────┘      └───────────────┘
```

## 5. Backend Separation

Use a modular monolith for the MVP. This keeps deployment simple while
preserving boundaries that can later become services if load or team ownership
requires it.

```text
backend/
  api/
    routes/
    middleware/
    schemas/
  application/
    auth/
    children/
    sessions/
    stories/
    rewards/
    data_controls/
  domain/
    curriculum/
    learning/
    content/
    rewards/
    privacy/
  ports/
    repositories/
    speech/
    narration/
    generation/
    telemetry/
  infrastructure/
    postgres/
    storage/
    ai/
    telemetry/
  workers/
    story_generation/
    narration/
    exports/
    deletion/
  migrations/
  tests/
```

### API/Transport Layer

Owns authentication middleware, parental-gate checks, request validation,
idempotency, rate limits, schema versioning, and response serialization. Route
handlers call one application use case and contain no learning rules.

### Application Layer

Coordinates transactions and domain services for actions such as starting a
session, evaluating an attempt, approving a story, or deleting an account. It
owns workflow, but delegates decisions to domain objects and external work to
ports.

### Domain Layer

Contains pure, deterministic rules and value objects. It has no network,
database, filesystem, framework, or provider imports. Most pedagogical tests
run here without infrastructure.

### Ports and Infrastructure

Ports are interfaces owned by the application/domain side. Infrastructure
implements those interfaces for Postgres, object storage, speech, narration,
generation, safety checks, and telemetry. Provider changes should be confined
to this layer plus configuration.

### Workers

Workers execute asynchronous workflows. API requests enqueue jobs and return
status resources; they do not hold open connections for story generation,
exports, account deletion, or long narration jobs.

## 6. Core Domain Boundaries

### Curriculum Engine

The curriculum engine owns:

- Skill graph and prerequisites.
- Approved grapheme-phoneme mappings and example words.
- Eligible activity templates for each skill.
- Hint ladders.
- Mastery rules and spaced review scheduling.
- Selection of the next learning objective.

It is deterministic application code operating on versioned curriculum data.
An LLM must never mark a skill mastered or alter prerequisites.

### Session Orchestrator

The orchestrator:

1. Reads the child's current skill state.
2. Selects eligible learning objectives.
3. Applies child theme and activity choices.
4. Builds a session plan from approved templates.
5. Accepts attempts and updates skill evidence.
6. Applies frustration, fatigue, and support policies.
7. Ends with a summary and reward event.

The server creates the authoritative session plan. The app caches enough of the
active plan to survive transient connectivity loss without losing attempts.

### Voice Pipeline

The voice subsystem is split into four responsibilities:

1. **Capture:** AVAudioEngine records only after a visible listening cue.
2. **Turn detection:** Client-side silence detection limits unnecessary upload.
3. **Recognition/evidence:** Server sends audio to a speech provider with a
   constrained set of expected answers and returns transcript, confidence, and
   pronunciation evidence.
4. **Feedback:** The learning engine decides whether to accept, retry, offer a
   hint, or use touch input.

For open-ended conversation, the transcript goes through the bounded
conversation service. For phoneme and word assessment, a free-form LLM response
is not accepted as the sole scoring signal.

### Narration Pipeline

- Common instructions, phonemes, and curriculum prompts use pre-generated,
  expert-reviewed audio when possible.
- Dynamic teacher responses and approved personalized stories use cloud TTS.
- Generated audio is cached by normalized text, voice version, and speaking
  rate to reduce cost and latency.
- Parent recordings remain separate from synthetic teacher audio and require
  explicit selection before playback.

Pre-generated phoneme audio is important because general TTS can pronounce
isolated letter sounds inconsistently or add an unwanted schwa.

### AI Policy Gateway

All AI calls pass through one backend module that:

- Removes unnecessary identifiers.
- Applies age, topic, and curriculum constraints.
- Enforces token, duration, and per-session cost limits.
- Rejects unsupported tool use and unrestricted web access.
- Validates structured output against schemas.
- Records provider, policy version, latency, and cost without logging raw child
  content by default.
- Supports provider replacement without changing curriculum code.

## 7. Frontend Separation

The Apple app is one binary with separate parent and child feature trees. It
uses feature-oriented presentation code over shared application, domain, and
infrastructure layers.

```text
IcanRead/
  App/
    CompositionRoot/
    Navigation/
  Presentation/
    Child/
      Home/
      SkillCheck/
      LearningSession/
      Activities/
      Stories/
      Rewards/
    Parent/
      Onboarding/
      Consent/
      Dashboard/
      StoryApproval/
      Recordings/
      DataControls/
    Shared/
      DesignSystem/
      Components/
  Application/
    UseCases/
    SessionRuntime/
    AudioCoordination/
  Domain/
    Models/
    RepositoryProtocols/
  Infrastructure/
    API/
    LocalPersistence/
    Audio/
    Auth/
    Telemetry/
  Resources/
    Assets/
    LocalizedContent/
    ReviewedAudio/
```

Use lightweight MVVM:

- SwiftUI views render state and emit user intents.
- `@Observable` presentation models call application use cases.
- Application use cases coordinate the session runtime and repositories.
- Frontend domain models contain no SwiftUI, networking, or persistence code.
- Repository protocols isolate remote APIs and local caching.
- Infrastructure adapters map transport DTOs to domain models.
- Avoid a global singleton service container; dependencies are created at the
  app root and explicitly injected.

Parent and child navigation are separate state machines. Entering parent mode
requires a parental gate; child mode cannot navigate to account, approval,
purchase, export, or deletion screens.

## 8. Data Layer

Every household-owned table includes `household_id`; RLS verifies membership.
The MVP UI allows one child, but the schema supports multiple children later.

### Identity and Consent

- `households`
- `parent_users`
- `household_memberships`
- `child_profiles`
- `parental_consents`
- `privacy_preferences`

### Curriculum

- `curriculum_versions`
- `skills`
- `skill_prerequisites`
- `graphemes`
- `phonemes`
- `word_items`
- `sentence_items`
- `activity_templates`
- `hint_ladders`

Curriculum content is immutable after publication. A child is pinned to a
version, and migrations between versions are explicit.

### Learning

- `skill_checks`
- `learning_sessions`
- `session_steps`
- `attempts`
- `skill_evidence`
- `skill_states`
- `error_patterns`
- `engagement_signals`

An `attempt` stores:

- Presented item and expected response.
- Input modality.
- Normalized response or result category.
- Recognition confidence.
- Support level: independent, hinted, modeled, or simplified.
- Response latency.
- Curriculum and scoring-policy versions.
- Optional reference to parent-approved retained audio.

Do not store a guessed transcript as definitive truth. Preserve provider
confidence and the scoring-policy decision separately.

### Content and Rewards

- `curated_stories`
- `generated_story_drafts`
- `story_reviews`
- `story_assets`
- `toy_catalog`
- `child_toys`
- `reward_events`
- `real_world_milestones`

Generated stories move through:

```text
draft -> automated_review_passed -> parent_approved -> published
                              \-> rejected
parent_approved -> withdrawn
```

Only `published` content is queryable by child-mode endpoints.

### Operations

- `ai_usage_events`
- `deletion_jobs`
- `audit_events`

Audit events must avoid raw child speech and generated story bodies.

## 9. API Contracts

Use versioned JSON APIs except where streaming audio requires WebSocket or
chunked transport.

Representative endpoints:

```text
POST   /v1/auth/parent-gate
POST   /v1/children
GET    /v1/children/{id}/profile
POST   /v1/children/{id}/skill-checks
POST   /v1/children/{id}/sessions
GET    /v1/sessions/{id}
POST   /v1/sessions/{id}/attempts
POST   /v1/sessions/{id}/voice-turn
POST   /v1/sessions/{id}/complete
GET    /v1/children/{id}/progress
GET    /v1/children/{id}/recommendations
POST   /v1/story-drafts
POST   /v1/story-drafts/{id}/approve
POST   /v1/story-drafts/{id}/reject
POST   /v1/parent-recordings
DELETE /v1/recordings/{id}
POST   /v1/account-export
DELETE /v1/account
```

All write endpoints use idempotency keys. Session and attempt requests include
schema, curriculum, and scoring-policy versions.

API DTOs are generated or validated from a versioned schema. The frontend maps
DTOs at its infrastructure boundary and does not expose transport optionality
throughout presentation code.

## 10. Adaptive Learning Algorithm

Start with an interpretable rules-based model rather than machine learning.

For every skill, maintain a confidence value derived from:

- Independent accuracy.
- Hint dependence.
- Recency and delayed retention.
- Transfer-item performance.
- Recognition uncertainty.
- Error severity and pattern.

Selection pseudocode:

```text
eligible = skills whose prerequisites are met
due = eligible skills needing spaced review
focus = highest-priority unmastered skill near current level
objective = balance(due, focus, frustration risk)
activities = templates valid for objective
offer child 2-3 theme/activity choices from activities
```

Scoring rules:

- Recognition confidence below threshold produces `unscored`, not `incorrect`.
- Hinted or modeled success is useful evidence but cannot independently produce
  mastery.
- Repeated middle-sound omissions schedule oral segmentation and tile-building
  practice before additional print-only reading.
- Fast guessing is not rewarded.
- After repeated supported attempts, simplify and end on a known item.

All thresholds live in versioned configuration and can be tuned without an app
release.

## 11. Story Generation

Story generation is asynchronous and parent-facing:

1. Parent requests a story using approved interests and a target skill.
2. Backend constructs a constrained word bank from the curriculum version.
3. AI returns schema-valid story text, read-aloud text, prompts, and illustration
   descriptions.
4. Deterministic validators check decodability, length, vocabulary, prohibited
   terms, personal data, and target-pattern coverage.
5. A safety model checks age appropriateness.
6. The parent previews and approves or rejects the draft.
7. Approved text receives narration and illustration assets.
8. Child mode receives only the immutable published version.

Do not generate recognizable copyrighted characters. Interests such as Godzilla
should become generic parent-approved concepts such as a friendly giant
creature unless licensed content is available.

## 12. Security and Privacy

### Authentication and Authorization

- Parent accounts use platform-supported secure authentication.
- Store session credentials in Keychain.
- Child mode has no independent credentials.
- Parent-only actions require a parental gate and a recent parent session.
- Postgres RLS is mandatory and covered by automated tests.
- Service-role credentials remain only in backend functions.

### Data Minimization

- Stream or upload short utterances; do not continuously record.
- Delete transient audio immediately after recognition.
- Retain selected audio only when the parent enables it.
- Use opaque child IDs with AI providers; do not send surname, address, contact
  information, or account identifiers.
- Keep raw child text out of analytics and crash reporting.

### Deletion

Account deletion:

1. Immediately revokes access.
2. Deletes or tombstones database rows according to legal requirements.
3. Deletes stored audio and generated assets.
4. Propagates deletion to subprocessors where supported.
5. Records a non-identifying completion receipt.

Deletion jobs must be idempotent, monitored, and retryable.

### Commercial Readiness

Before external distribution:

- Complete threat modeling and privacy impact assessment.
- Obtain legal review for COPPA, state privacy laws, consent language, and
  parental verification requirements.
- Execute appropriate data-processing agreements with providers.
- Publish subprocessor, retention, privacy, and deletion documentation.
- Verify that no SDK uses child data for advertising or model training.

## 13. Reliability and Performance

Targets for the family MVP:

- App launch to usable child home: under 2 seconds on a supported recent device.
- Cached activity transition: under 300 ms.
- First teacher audio for cached prompts: under 250 ms.
- Dynamic voice response begins: target under 1.5 seconds on a good connection.
- Session attempt durability: no loss after acknowledged submission.
- API availability target: 99.5% during MVP; raise before commercial launch.

Resilience:

- Prefetch the next activity and common audio.
- Cache the active session plan and queue attempts locally.
- Retry writes with idempotency keys and exponential backoff.
- On AI outage, use curated content, pre-generated audio, and touch input.
- Never block a child session on analytics.

## 14. Cost Controls

- Prefer curated prompts and pre-generated audio for repeated content.
- Cache TTS by content hash and voice configuration.
- Limit open-ended voice turns by duration and response size.
- Use constrained recognition instead of a large generative model when possible.
- Generate stories asynchronously and only from parent mode.
- Enforce per-request and per-session AI budgets at the gateway.
- Track estimated cost by provider, feature, and session.
- Set alerts for abnormal usage and hard household rate limits.

The build-time token budget of $100 affects implementation workflow, not runtime
architecture. Runtime provider costs require a separate per-family target before
commercial pricing is set.

## 15. Testing Strategy

### Unit Tests

- Frontend presentation models with fake use cases and repositories.
- Curriculum prerequisites and versioning.
- Session selection and spaced review.
- Mastery and hint-dependence rules.
- Wait, hint, model, simplify transitions.
- Reward issuance and milestone idempotency.
- Generated-story deterministic validators.

### Integration Tests

- Frontend API adapters against contract fixtures.
- Backend application use cases against repository and provider fakes.
- Auth and RLS household isolation.
- Attempt ingestion and duplicate handling.
- Speech provider uncertainty and timeout fallbacks.
- Story generation, review, approval, and withdrawal.
- Audio retention and deletion.
- Full account export and deletion.

### UI Tests

- Parent onboarding and consent.
- Skill check completion.
- Each activity using touch fallback.
- Microphone permission denied and interrupted.
- Child help, replay, break, change, and stop actions.
- Parent story approval and recording deletion.
- iPhone and iPad layouts, Dynamic Type, VoiceOver, and Reduce Motion.

### Content Tests

- Every item matches its declared phonics pattern.
- No item requires an untaught pattern unless marked teacher-read.
- Isolated phoneme audio receives human review.
- Generated-content adversarial tests cover violence, fear, personal data,
  commercial characters, unsafe instructions, and prompt injection.

### Architecture Tests

- Backend domain packages cannot import infrastructure or transport packages.
- Backend routes cannot import Postgres or AI adapters directly.
- Frontend presentation cannot import API clients or persistence adapters.
- Child presentation cannot link parent-only use cases.
- API contract compatibility is checked in CI.

## 16. Delivery Plan

### Phase 0: Foundation

- Create Apple project, backend project, CI, environments, and typed API layer.
- Implement auth, one-child profile, consent, telemetry policy, and design
  system.
- Encode the first expert-reviewed curriculum slice.
- Deliver a runnable fixture-mode parent setup and child home before the
  learning loop.
- Maintain `CHANGELOG.md` and `ACS.md` after each completed, verified build
  increment; update product documents whenever implementation changes their
  stated behavior or boundaries.

Phase 0 does not claim learning activities, voice recognition, narration,
rewards, or skill assessment as available capabilities. Curriculum scaffolding
remains draft until qualified review.

### Phase 1: Learning Loop

- Build skill check, curriculum engine, session orchestrator, attempts, and
  parent progress view.
- Implement sound games, movable letters, word building, and spoken reading.
- Add reviewed phoneme audio and touch fallback.

### Phase 2: Full MVP Activities

- Add tracing, decodable stories, scavenger hunts, and role-play.
- Add rewards, toy collection, and real-world milestone flow.
- Add bounded teacher conversation and adaptive support.

### Phase 3: Personalization and Hardening

- Add generated-story approval workflow and parent recordings.
- Complete deletion/export, cost controls, accessibility, failure modes, and
  security tests.
- Run supervised child usability sessions and literacy-expert review.

### Phase 4: Family Release

- Fix observed learning and usability failures.
- Complete privacy/legal review appropriate to the distribution method.
- Ship through TestFlight first, then a controlled App Store release.

## 17. Key Architecture Decisions

1. **Native SwiftUI over cross-platform:** The MVP targets only Apple devices
   and depends heavily on audio, touch, accessibility, and polished iPad UI.
2. **Managed backend over custom infrastructure:** Supabase reduces setup time
   while retaining portable Postgres data and explicit authorization policies.
3. **Rules-based pedagogy over AI-selected teaching:** Learning behavior remains
   reviewable, testable, and aligned with the approved curriculum.
4. **Pre-generated core audio plus dynamic TTS:** This improves phoneme quality,
   latency, reliability, and cost without losing personalized narration.
5. **Parent-approved asynchronous story generation:** This prevents unreviewed
   AI content from reaching the child and keeps generation out of the lesson's
   critical path.
6. **Multi-household schema with one-child MVP UI:** This avoids an expensive
   commercial migration while keeping the first product tightly scoped.
7. **Modular monolith over microservices:** Explicit modules and ports provide
   separation without premature distributed-system complexity.
8. **Frontend/backend contract boundary:** The Apple app consumes versioned APIs
   only; data stores and AI providers remain private backend concerns.
