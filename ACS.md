# Application Capability Snapshot

**Snapshot date:** 2026-06-07

**Build state:** Phase-one native iOS foundation with debug learning-loop preview

**Data mode:** SwiftData fixture persistence by default; Supabase is cloud-ready

## Current Capabilities

### Parent Experience

- Enter through Sign in with Apple presentation or a debug-only local demo path.
- Review and accept required microphone and cloud-processing consent.
- Keep selected audio retention disabled or explicitly opt in.
- Create one child profile with first name, age, interests, and accessibility
  preferences.
- Review setup and enter child mode.
- Re-enter setup through an arithmetic parental gate.

### Child Experience

- In the native iOS app, see the persisted personalized child home after setup.
- Open Adventure and complete a four-turn, touch-based fixture sound check.
- Replay unreviewed synthetic preview phonemes, request progressively stronger
  support, pause, resume, and stop without losing the active turn.
- Receive neutral response feedback without a score or mastery claim.
- Open Stories, Toy Shelf, and My Creations capability previews.
- See explicit messaging that fixture curriculum and audio are not approved
  instruction.
- Remain separated from parent controls by a parental gate.

### Parent Learning Evidence

- Enter a parent-gated reading overview after the fixture sound check.
- Review completed turns, independent matches, supported matches, and attempts
  that led to a clue.
- See an explicit warning that fixture evidence cannot establish placement or
  mastery.

### Data and Backend

- Persist the single child profile and setup state locally using SwiftData.
- Persist active fixture sessions and attempt evidence locally using SwiftData.
- Default to fixture mode when no API base URL is configured.
- Provide Supabase migrations for households, parents, memberships, child
  profiles, consent, privacy preferences, and initial curriculum structures.
- Enforce household-scoped RLS policies for profile and consent data.
- Keep the initial `/m/`, `/a/`, `/t/`, `/s/`, `/p/`, and `/i/` content marked
  as draft and inaccessible through published-curriculum policies.
- Define the phase-one API contract and implement `GET /v1/health`.

### Accessibility and Privacy

- Use large child controls, semantic labels, scalable parent text, and
  configurable reduced-motion, captions, and slower-voice preferences.
- Retain no child audio in the current build.
- Store response latency as private attempt evidence rather than a child-facing
  score.
- Store no production credentials in the application.
- Keep account and parent setup controls outside child navigation.

## Verification Status

- Generated `ICanRead.xcodeproj` successfully from `project.yml`.
- Archived, validated, signed, and uploaded build `0.1.0 (1)` to App Store
  Connect; Apple accepted the package for TestFlight processing.
- Built and launched without warnings on iPhone 17 Pro and iPad Pro 13-inch
  simulators running iOS 26.2.
- Completed the fixture-mode setup journey on iPhone: required consent, child
  name, interests, accessibility preferences, review, and child home.
- Confirmed the saved child profile survives application termination and
  relaunch.
- Confirmed child mode requires the arithmetic parental gate before returning
  to parent learning evidence or setup.
- Completed the four-turn fixture sound adventure on iPhone, including an
  incorrect response, hint escalation, pause/resume, completion, and the
  parent-gated evidence summary.
- Confirmed the active fixture session and attempts persist through view
  transitions.
- Passed all ten domain unit tests for setup, configuration, deterministic
  session order, attempt classification, support escalation, pause/resume,
  uncertainty, and completion summary.
- Database pgTAP tests are authored for foundational schema and RLS presence.
- CI is configured to generate the Xcode project, build and test the app, reset
  the local database, run database tests, and validate documentation.
- Documentation contract and whitespace checks pass locally.
- Local Supabase migrations and pgTAP tests were not executed because the
  installed Docker daemon was unavailable.

## Required Configuration

- Xcode 16 or newer with an iOS 17+ simulator.
- XcodeGen to generate `ICanRead.xcodeproj` from `project.yml`.
- Apple Developer team `B7879S5SL4` and App Store Connect access are required
  for signed distribution.
- Docker and Supabase CLI to run the local backend.
- No environment variables are required for fixture mode.
- Set `ICANREAD_API_BASE_URL` only when using a backend environment.

## Known Limitations

- The sound adventure is debug-only fixture content, not an approved skill
  check or validated placement instrument.
- Synthetic preview phonemes are unreviewed and must not be treated as
  instructional audio.
- Voice capture, speech recognition, approved narration, authoritative mastery,
  stories, rewards, progress trends, and AI conversation are not implemented.
- Sign in with Apple displays the native control but its credential is not yet
  exchanged with Supabase.
- Authenticated profile API routes are contracted but return `501` until the
  next backend increment.
- The current dragon-storybook app icon is temporary TestFlight artwork and
  requires final brand review.
- TestFlight processing and installation on a physical iPhone have not yet
  been verified.
- Curriculum seed data is draft schema-validation content, not expert-reviewed
  instruction.

## Next Intended Build Increment

Replace fixture prompts and synthetic phonemes with literacy-expert-reviewed
curriculum and reviewed recordings, then add an authoritative starting-placement
workflow and remote attempt synchronization.
