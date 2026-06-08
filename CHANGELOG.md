# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Debug-only playful sound-adventure preview with four deterministic touch
  turns, replay, help, pause, and touch fallback.
- SwiftData persistence for active skill-check sessions and attempt evidence.
- Deterministic wait, hint, model, and simplify support progression.
- Parent-gated fixture evidence summary that avoids scores and mastery claims.
- Versioned preview phoneme-audio descriptors and synthetic debug playback,
  explicitly marked as unreviewed.
- Apple Developer signing, App Store release metadata, supported orientation
  declarations, and a temporary dragon-storybook TestFlight app icon.
- Native SwiftUI iPhone/iPad application foundation.
- Locally persisted parent setup for consent, child profile, interests, and
  accessibility preferences.
- Child home with honest capability previews and a parental gate.
- Layered frontend domain, presentation, and infrastructure structure.
- Supabase local configuration, foundation schema, household RLS policies, and
  draft curriculum seed data.
- Versioned OpenAPI foundation contract and health function.
- Unit tests, CI workflow, and documentation contract.
- Persistent Application Capability Snapshot in `ACS.md`.
- Verified fixture-mode setup and persistence on iPhone and the responsive
  foundation layout on iPad.

### Changed

- Adventure now opens the first learning-loop fixture instead of a capability
  placeholder.
- Child home and learning screens now more closely follow the warm natural,
  tactile visual direction in the design concepts.
- Build `0.1.0 (1)` was archived, validated, and uploaded to App Store Connect
  for TestFlight processing.
- Architecture documentation now defines the phase-one documentation maintenance
  requirement.
- Removed obsolete prototype runtime files superseded by the native iPhone/iPad
  foundation.

## [0.0.0] - 2026-04-28

### Added

- Initial product, architecture, and design specifications.
