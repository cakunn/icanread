# I Can Read: Living Product Requirements Document

## Document Status
- **Product:** I Can Read phonics practice game
- **Audience:** Early reader, age 7, with parent support
- **Status:** Draft, living
- **Last updated:** 2026-05-06
- **Source:** Converted from `phonics_game_plan.md`

## Purpose
Build a playful reading practice game where a child reads short, funny sentences out loud and receives warm, teacher-like feedback. The product should strengthen phonics decoding, treat sight words as memory words, celebrate effort, and track growth over time.

This PRD is intended to stay evergreen. Update it as implementation choices, learning data, child needs, and product constraints become clearer.

## How to Maintain This PRD
- Update **Document Status** whenever scope, milestones, or product direction changes.
- Add product decisions to the **Decision Log** instead of burying them in prose.
- Add meaningful edits to the **Change Log** with the date and author.
- Keep **Open Questions** current by removing answered questions and adding new unknowns.
- Treat requirements as living commitments: tighten wording as the product moves from idea to implementation.
- Review this document before starting a major feature, milestone, or user-facing redesign.

## Product Principles
- **Reading first:** Every feature should help the child practice reading, decoding, or confidence.
- **Praise before correction:** Feedback should make mistakes feel normal, fixable, and safe.
- **Short sessions:** The product should respect attention, fatigue, and emotional energy.
- **Growth over speed:** Rewards should celebrate effort, self-correction, bravery, and learning.
- **Parent-visible, child-kind:** Progress views should help adults support the child without making the child feel judged.
- **Phonics and sight words are different:** Decodable words should be taught through sounds; sight words should be recognized and remembered.

## Target Users

### Primary User: Child Reader
- Age: approximately 7
- Needs short, playful, confidence-building reading practice
- Benefits from immediate feedback, silly content, repetition, and visible wins
- May misread words, skip words, guess, or be affected by speech recognition errors

### Secondary User: Parent or Caregiver
- Wants to support reading practice without turning it into a fight
- Needs simple progress summaries and gentle review suggestions
- Needs override tools when speech recognition is wrong

## Core User Experience

### Session Flow
1. **Warm-up: 2 minutes**
   - Show 3 familiar words from previous sessions.
   - Favor confidence wins and recently mastered words.
   - Use language such as: "You already know these!"

2. **Story round: 5-10 minutes**
   - Show one short, silly sentence at a time.
   - Child reads aloud.
   - App listens and evaluates the attempt.
   - Feedback should praise first, then teach one small thing if needed.

3. **Word spotlight: 1-2 minutes**
   - Pick 1-2 tricky words from the round.
   - For phonics words, decompose into chunks and sounds.
   - For sight words, reinforce quick recognition.
   - Re-read the word in the original sentence.

4. **Victory recap: 1 minute**
   - Show words read correctly.
   - Award stars or badges.
   - End with a positive, teacher-style message.

### Ideal Session Length
- MVP: 5-8 minutes
- Later: configurable 5, 10, or 15 minute sessions
- Sessions should always have a graceful stopping point.

## Functional Requirements

### Reading Practice
- The app must show short, level-appropriate sentences.
- The app must support micro-stories made of 2-4 connected lines.
- The app must let the child read aloud one sentence at a time.
- The app should support repeating a sentence before or after feedback.
- The app should avoid overwhelming the child with too much text at once.

### Speech Recognition and Evaluation
- The app must capture spoken reading attempts.
- The app should compare the spoken attempt to the target sentence word by word.
- The app should identify likely correct words, missed words, substituted words, and uncertain words.
- The app must allow parent override when speech recognition marks a correct reading as wrong.
- The app should not punish unclear audio, background noise, or speech-recognition uncertainty.

### Voice and Delivery Requirements
- Spoken feedback voice must sound natural, warm, and human-like (not robotic).
- Default voice model should prioritize low cost for high-frequency use.
- Voice playback should begin quickly after evaluation to preserve reading flow.
- If voice fails, text feedback must still appear immediately.

### Feedback Engine
Every feedback turn should follow this pattern:
1. Celebrate effort.
2. Name what was correct.
3. Teach one small thing.
4. Invite a retry.
5. Close with success language.

Tone rules:
- Keep feedback short: 1-3 sentences.
- Never shame mistakes.
- Focus on one correction at a time.
- Prefer specific praise over generic praise.
- Always end with confidence or success language.

Example feedback for a phonics error:
> Great effort. Let's check one word: **bird**. Say the sounds with me: **/b/ - /ir/ - /d/**. Blend it: **bird**. Now try the whole sentence again.

Example feedback for a sight-word error:
> Nice trying! This word is a snap word: **the**. We remember it quickly. Can you point to **the** and read the sentence again?

Example feedback for self-correction:
> You fixed it yourself. That is what strong readers do.

### Phonics Words
The app must support decodable words with optional segment views.

Examples:
- Normal: `bird`
- Segmented: `b | ir | d`
- Sound cues: `/b/ /ir/ /d/`

More examples:
- `ship` -> `sh | i | p`
- `black` -> `bl | a | ck`
- `jumped` -> `j | u | m | p | t`

### Sight Words
The app must visually distinguish sight words from decodable words.

Requirements:
- Use a consistent highlight color, chip, underline, or icon label.
- Label them as "Snap Word" or equivalent child-friendly language.
- Keep a rotating wall of mastered sight words.
- Teach sight words as fast-recognition memory words, not sound-by-sound decoding.

Initial examples:
- `the`
- `was`
- `said`
- `come`
- `you`

### Motivation and Rewards
The app should use rewards to praise growth, not speed.

MVP rewards:
- 1 star for finishing a sentence.
- Bonus star for correcting a word after coaching.
- Bravery badge for trying hard words.
- Phonics detective badge for blending sounds successfully.

Avoid:
- Red error-heavy screens
- Timed pressure
- Public failure states
- Streak mechanics that make missed days feel bad

### Parent Dashboard
The dashboard should provide simple, encouraging summaries.

Example summaries:
- "Words mastered this week: 12"
- "Top confidence words: cat, mat, red, bird"
- "Needs gentle review: was, said, shirt"
- "Best moment: self-corrected `bird` after blending sounds"

The dashboard should support:
- Weekly mastery summary
- Words needing review
- Recently practiced stories
- Parent correction overrides
- Session length and difficulty preferences

## Content Requirements

### Micro-Story Rules
- Stories should make narrative sense.
- Each story should have a clear setup, action, and resolution.
- Stories should be short, silly, and level-appropriate.
- Stories should alternate across positive themes such as friendship, kindness, curiosity, helpfulness, perseverance, courage, ambition, politeness, boldness, love, understanding, caring, openness, analysis, problem solving, growth, respect, honor, bravery, and learning.
- Characters may be people, animals, objects, robots, toys, or other child-friendly things.
- Content should feel playful in the spirit of simple phonics readers such as *The Fat Cat on a Mat*.

### Example Micro-Stories

#### Story 1: Friendship
1. "Max met a yak by the bus stop."
2. "The yak said, 'Can pals share snacks?'"
3. "Max and yak split a pack and sat to chat."

#### Story 2: Kindness
1. "Nia saw a wet pup in the rain."
2. "She set out a cup and a soft red rag."
3. "The pup gave Nia a big tail wag."

#### Story 3: Curiosity
1. "Ben found a box with a tiny lock."
2. "He said, 'Hmm, what can this be?'"
3. "It held a map of the park and a duck."

#### Story 4: Helpfulness
1. "Dot the robot had a lot to lug."
2. "Tim said, 'I can help with that tub!'"
3. "Dot beeped, 'Thanks, pal!' and did a happy spin."

#### Story 5: Perseverance
1. "Liv tried to hop on one leg and slip-kicked a sock."
2. "She fell, then stood, then tried again."
3. "At last, Liv did ten hops and grinned."

#### Story 6: Courage
1. "A kid named Jo heard a thump in the shed."
2. "Jo took a breath and checked with a light."
3. "It was just a cat in Dad's old hat."

#### Story 7: Politeness and Respect
1. "At lunch, Raj said, 'May I have jam, please?'"
2. "Kim said, 'Yes, and thanks for asking nice.'"
3. "They both said, 'You're welcome,' with smiles."

#### Story 8: Problem Solving and Growth
1. "Mia's kite got stuck up high in a tree."
2. "She made a plan: stick, string, and hook."
3. "The kite slid down, and Mia said, 'I learned a new trick!'"

#### Story 9: Bravery and Caring
1. "Zed heard peeps from a box by the gate."
2. "He felt scared, but he still took a look."
3. "Two chicks were cold, so Zed got a warm crate."

#### Story 10: Openness and Understanding
1. "Ana liked bats; Lee liked frogs."
2. "They said, 'Let's swap facts and learn both!'"
3. "Now they cheer for bats and frogs at dusk."

## Data Requirements

### ChildProfile
- `id`
- `name`
- `age`
- `interests`
- `preferredPraiseStyle`
- `sessionLengthPreference`
- `difficultyPreference`
- `createdAt`
- `updatedAt`

### WordRecord
- `id`
- `childId`
- `word`
- `type`: `phonics` or `sight`
- `phonicsPattern`
- `attempts`
- `correctFirstTryCount`
- `correctAfterPromptCount`
- `lastSeenAt`
- `masteryLevel`: `new`, `practicing`, `strong`

### SentenceRecord
- `id`
- `sentenceText`
- `wordList`
- `targetPatterns`
- `attempts`
- `success`
- `createdAt`

### SessionRecord
- `id`
- `childId`
- `startedAt`
- `endedAt`
- `totalStars`
- `badgesAwarded`
- `wordsPracticed`
- `storiesPracticed`
- `parentOverrides`

## Metrics

### Product Success Metrics
- Child completes at least 3 sessions per week.
- Child finishes sessions with neutral or positive sentiment.
- Parent can understand progress in under 30 seconds.
- Mastered word count increases week over week.
- Retry success rate improves over time.

### Learning Metrics
- Words correct on first attempt
- Words corrected after prompt
- Self-corrections
- Sight words recognized quickly
- Phonics patterns blended successfully
- Words needing gentle review

### Quality Metrics
- Speech recognition uncertainty rate
- Parent override rate
- Feedback latency
- Session completion rate
- Child-requested repeat rate

## MVP Scope

### In Scope
- Word bank tagged as `phonics` or `sight`
- Short silly sentence and micro-story content
- Read-aloud sentence flow
- Speech recognition pipeline
- Word-by-word comparison
- Praise -> teach -> retry feedback engine
- Phonics segmentation renderer
- Sight-word highlighter
- Per-word mastery stats
- Stars, badges, and session recap
- Parent progress summary
- Manual parent override

### Out of Scope for MVP
- Multiplayer or classroom mode
- Complex adaptive curriculum
- Social sharing
- Timed reading races
- Full teacher administration tools
- Long-form stories
- External school-system integrations

## Rollout Plan

### Weeks 1-2: Confidence and Routine
- Launch 5-8 minute sessions.
- Reuse known CVC patterns such as `cat`, `mat`, and `sat`.
- Introduce basic reward screen.
- Add parent override for speech recognition mistakes.

### Weeks 3-4: Slow Complexity Increase
- Mix CVC words with digraphs such as `sh`, `ch`, and `th`.
- Introduce 3-5 sight words in rotation.
- Start word spotlight review.
- Add a small mastered sight-word wall.

### Weeks 5-6: Stamina and Independence
- Add slightly longer mini-stories.
- Let the child choose the next story theme.
- Add "read it with expression" bonus.
- Expand parent dashboard summaries.

## UX and Safety Requirements
- Keep sessions short to avoid fatigue.
- Allow sentence replay.
- Include slower read-aloud support.
- Include parent override for recognition mistakes.
- Store the minimum child data needed for progress tracking.
- Make privacy settings clear.
- Avoid shame, ranking, public comparison, or pressure.
- Prefer calm, readable screens with large text and obvious controls.

## Open Questions
- Which speech recognition provider will best handle child speech?
- Should the app use local-only storage first, cloud sync, or both?
- What phonics sequence should define progression?
- How should parent overrides affect mastery calculations?
- Should stories be generated dynamically, curated manually, or hybrid?
- How should the product detect fatigue or frustration?

## Decision Log
| Date | Decision | Rationale |
| --- | --- | --- |
| 2026-05-05 | Treat phonics words and sight words differently in UI and feedback. | Decodable words require sound-letter mapping; sight words require recognition and memory. |
| 2026-05-05 | Rewards praise growth, effort, and correction rather than speed. | The product should build confidence and resilience, not pressure. |
| 2026-05-05 | Micro-stories alternate positive character themes. | Stories should support both reading practice and character growth. |

## Change Log
| Date | Change | Author |
| --- | --- | --- |
| 2026-05-06 | Converted original game plan into living PRD. | Codex |
