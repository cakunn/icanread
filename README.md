# I Can Read

An Apple-first, child-led structured-phonics reading tutor. The current build is
the phase-one native iPhone/iPad foundation with a debug-only fixture sound
adventure. The fixture content and synthetic phonemes are unreviewed and do not
produce placement or mastery.

## Run the iOS App

Requirements:

- Xcode 16+
- XcodeGen

```sh
brew install xcodegen
xcodegen generate
open ICanRead.xcodeproj
```

Select the `ICanRead` scheme and an iOS 17+ iPhone or iPad simulator. Without
configuration, the debug build uses local fixture mode.

Run tests:

```sh
xcodebuild test \
  -project ICanRead.xcodeproj \
  -scheme ICanRead \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  CODE_SIGNING_ALLOWED=NO
```

## TestFlight Distribution

The project uses Apple Developer team `B7879S5SL4`, bundle identifier
`com.cakunn.icanread`, and version `0.1.0`. Build numbers must increase for each
App Store Connect upload. Build `0.1.0 (1)` was uploaded on June 7, 2026.

## Run Supabase Locally

Requirements:

- Docker
- Supabase CLI

```sh
brew install supabase/tap/supabase
supabase start
supabase db reset
supabase test db
```

Copy values from `.env.example` into a local ignored environment file when
connecting the app to the backend. Fixture mode requires no secrets.

## Project Structure

- `ICanRead/`: SwiftUI presentation, application/domain models, and adapters.
- `ICanReadTests/`: App unit tests.
- `backend/contracts/`: Versioned public API contract.
- `supabase/`: Local platform configuration, migrations, functions, and tests.
- `PRD.md`, `ARCHITECTURE.md`, `DESIGN.md`: Product source documents.
- `ACS.md`: Latest verified application capability snapshot.
- `CHANGELOG.md`: Increment history.

## Documentation Workflow

Read `ACS.md` before starting work. After each completed and verified build
increment, update `CHANGELOG.md`, `ACS.md`, and every product document affected
by the change. `AGENTS.md` contains the mandatory Definition of Done.
