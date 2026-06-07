# Application Capability Snapshot

**Snapshot date:** 2026-06-07

**Build state:** Phase-one native iOS foundation

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
- Open Adventure, Stories, Toy Shelf, and My Creations capability previews.
- See explicit messaging that learning activities are not implemented yet.
- Remain separated from parent controls by a parental gate.

### Data and Backend

- Persist the single child profile and setup state locally using SwiftData.
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
- Store no production credentials in the application.
- Keep account and parent setup controls outside child navigation.

## Verification Status

- Generated `ICanRead.xcodeproj` successfully from `project.yml`.
- Built and launched without warnings on iPhone 17 Pro and iPad Pro 13-inch
  simulators running iOS 26.2.
- Completed the fixture-mode setup journey on iPhone: required consent, child
  name, interests, accessibility preferences, review, and child home.
- Confirmed the saved child profile survives application termination and
  relaunch.
- Confirmed child mode requires the arithmetic parental gate before returning
  to parent setup.
- Passed all four domain unit tests for setup validation, optional audio
  retention, and fixture/remote configuration selection.
- Database pgTAP tests are authored for foundational schema and RLS presence.
- CI is configured to generate the Xcode project, build and test the app, reset
  the local database, run database tests, and validate documentation.
- Documentation contract and whitespace checks pass locally.
- Local Supabase migrations and pgTAP tests were not executed because the
  installed Docker daemon was unavailable.

## Required Configuration

- Xcode 16 or newer with an iOS 17+ simulator.
- XcodeGen to generate `ICanRead.xcodeproj` from `project.yml`.
- Docker and Supabase CLI to run the local backend.
- No environment variables are required for fixture mode.
- Set `ICANREAD_API_BASE_URL` only when using a backend environment.

## Known Limitations

- Native iOS learning activities, skill checks, voice capture, speech
  recognition, TTS, stories, rewards, progress reporting, and AI conversation
  are not implemented.
- Sign in with Apple displays the native control but its credential is not yet
  exchanged with Supabase.
- Authenticated profile API routes are contracted but return `501` until the
  next backend increment.
- The app icon does not yet have final artwork.
- Curriculum seed data is draft schema-validation content, not expert-reviewed
  instruction.

## Next Intended Build Increment

Verify and harden the foundation build, then implement the first learning-loop
slice: playful skill-check entry, deterministic session state, one sound game,
attempt evidence, reviewed phoneme audio, and touch fallback.
