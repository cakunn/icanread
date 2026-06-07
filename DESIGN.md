# I Can Read - UX, UI, and Pedagogy Design Guidelines

## 1. Purpose

This document defines how I Can Read should feel, behave, speak, and teach. It
is the shared contract for product design, curriculum design, content, voice,
illustration, and frontend implementation.

The experience is for a 7-year-old who can decode simple words but finds each
word effortful. Design must reduce cognitive load, preserve agency, and make
careful phonics practice feel like meaningful play. It must not disguise drills
with distracting rewards or turn reading into a performance test.

## 2. Experience Principles

1. **One learning idea at a time.** Each screen has one primary task and one
   spoken instruction.
2. **Choice within useful boundaries.** Offer two or three pedagogically valid
   choices, not an unlimited menu.
3. **The child controls pace.** Help, replay, break, activity change, and stop
   remain available.
4. **Quiet before help.** Do not interrupt productive thinking.
5. **Concrete before abstract.** Let the child hear, say, move, and trace before
   expecting fluent print reading.
6. **Meaning accompanies mechanics.** Decoding practice connects to pictures,
   actions, stories, or conversation without encouraging guessing.
7. **Errors are information.** Respond neutrally, preserve dignity, and adapt.
8. **Success is real.** Celebrate effort and strategy freely; reserve mastery
   language for demonstrated retained skill.
9. **Calm is compatible with fun.** Use imagination, humor, and satisfying
   interactions without visual noise, urgency, or overstimulation.
10. **The adult remains responsible.** Parent controls, approvals, and learning
    explanations are clear and accessible.

## 3. Experience Architecture

### Child Mode

Child mode contains five destinations:

- **Adventure:** Start or continue the suggested learning session.
- **Stories:** Choose from curated and parent-approved stories.
- **Toy Shelf:** Play briefly with earned virtual toys.
- **My Creations:** Revisit traced letters, built words, or narrated stories.
- **Pause:** Take a quiet break or end the session.

Do not use a conventional text-heavy tab bar during a lesson. The active
session is a focused, linear flow with controlled choices between activities.

### Parent Mode

Parent mode contains:

- **Overview:** Plain-language progress and recent session summaries.
- **Skills:** Mastered, developing, and currently supported skills.
- **Patterns:** Recurring errors and suggested offline activities.
- **Stories:** Generate, review, approve, withdraw, or delete stories.
- **Recordings:** Create encouragement clips and manage retained child audio.
- **Rewards:** Configure the real-world milestone reward.
- **Settings and Privacy:** Consent, data export, deletion, and preferences.

Entry requires a parental gate that is difficult for a young child but quick
for an adult. Parent mode follows standard iOS conventions and supports Dynamic
Type.

## 4. Core Child Journey

### 4.1 Welcome

- Greet the child by first name only when enabled.
- Use a short teacher utterance, such as "Ready for a sound adventure?"
- Present two or three large illustrated theme cards based on current interests.
- Include a quiet "Not now" option.
- Never show missed days, overdue work, rankings, or an unfilled daily goal.

### 4.2 Activity Choice

Offer only activities valid for the selected learning objective. Phrase choices
as actions:

- "Build words"
- "Hunt for sounds"
- "Read a creature story"

The app may recommend one choice but must not make alternatives look inferior.
After the child chooses, begin promptly without a loading-heavy transition.

### 4.3 Learning Activity

Every activity screen contains:

- A stable task area in the center.
- The teacher's short instruction in voice and optional text.
- A persistent replay control.
- A visible microphone state when voice is relevant.
- A low-emphasis help control.
- An always-reachable pause control.
- No unrelated reward meter or navigation.

Begin with one familiar item, then introduce the target challenge. Keep an
activity to roughly three to seven turns before offering a transition.

### 4.4 Reflection and Reward

End with a specific observation:

- "You listened for the middle sound."
- "You tried it again with the tiles."
- "You asked for a clue when you needed one."

Then reveal earned toy progress. Keep the reveal brief and skippable. Offer two
equal choices: stop for now or choose another short activity.

## 5. Teaching Interaction Model

### Wait, Hint, Model, Simplify

The UI and teacher voice implement the same four-state support ladder.

#### Wait

- Allow age-appropriate silence after the prompt.
- Show a gentle listening or thinking state, not a countdown.
- Do not repeat the prompt merely because the child is slow.
- If the microphone detects no usable response, ask whether to hear it again or
  answer another way.

#### Hint

Give one minimal cue matched to the task:

- Replay the target sound.
- Highlight the relevant grapheme.
- Stretch a continuous sound.
- Expose sound boxes one at a time.
- Ask, "What sound do you hear in the middle?"

Do not combine several hints in one turn.

#### Model

- Demonstrate the process, not only the answer.
- Visually synchronize sounds with letters or sound boxes.
- Invite a low-pressure retry: "Let's do it together."
- Record the result as modeled evidence, not independent mastery.

#### Simplify

- Reduce the number of choices or phonemes.
- Return from print to sound or movable tiles.
- Contrast two clear examples.
- Follow with a familiar success.
- Schedule the original challenge for a later session.

Never use a red error state, buzzer, shaking control, lost reward, or repeated
"wrong" message.

## 6. Pedagogy Guidelines

### Structured Phonics

- Follow the approved cumulative scope and sequence.
- Use only words decodable from taught patterns unless a word is explicitly
  marked as teacher-read.
- Teach grapheme-phoneme relationships directly.
- Teach high-frequency irregular words by mapping their regular and unexpected
  parts, not by shape memorization or picture guessing.
- Mix review with new material and revisit skills after increasing intervals.

### Phonemic Awareness

- Include listening activities without print.
- Explicitly practice identifying, blending, segmenting, adding, deleting, and
  substituting sounds at the child's current level.
- Give special attention to medial vowels and omitted middle sounds.
- Accept plausible pronunciation variation; do not confuse accent or speech
  production with phonemic understanding.

### Encoding Before and Alongside Decoding

- Frequently ask the child to build a spoken word before reading it.
- Use sound boxes and one tile per phoneme before showing conventional spelling.
- Accept developmentally useful invented spelling in open creation.
- In explicit instruction, model conventional spelling after acknowledging the
  sounds the child represented.

### Fluency

- Build accuracy and confidence before increasing pace.
- Model smooth reading, then invite echo or shared reading.
- Use rereading when the text is meaningful and the child agrees.
- Never display words per minute, speed scores, or timers to the child.
- Treat response latency as private diagnostic evidence only.

### Comprehension and Language

- Separate decodable child text from richer teacher-read language.
- Ask one authentic question at a time.
- Prefer prediction, cause, emotion, explanation, retelling, and connection
  questions over recall quizzes.
- Accept spoken answers, gestures, drawings, acting, or sequencing pictures.
- Briefly explain useful vocabulary in context without derailing the story.

### Montessori-Informed Practice

- Present orderly, predictable materials with a clear purpose.
- Demonstrate an activity concisely, then allow independent exploration.
- Avoid unnecessary interruption or correction during concentration.
- Offer bounded freedom to choose theme, modality, and whether to continue.
- Build self-correction into materials where possible, such as tiles fitting
  sound boxes or audio replay for comparison.
- Use the environment and activity response rather than constant adult praise
  as feedback.
- Do not call the product "Montessori certified" without appropriate review.

## 7. Voice UX

### Teacher Character

The teacher is a warm, capable guide, not a cartoon baby voice or synthetic
best friend.

- General American English.
- Female voice with clear articulation and natural warmth.
- Calm, lightly playful, and respectful.
- Slightly slower than adult conversation, without distorting sounds.
- Brief phrases and one instruction per turn.
- Uses contractions and natural language.
- Does not overuse the child's name or praise.
- Never claims feelings, dependency, secrecy, or a human relationship.

### Voice Writing

Prefer:

- "Touch each sound, then blend the word."
- "Take your time. I'm listening."
- "You found the first sound. Let's listen for the middle."
- "Would you like a clue or the tiles?"

Avoid:

- "That's easy."
- "You already learned this."
- "Wrong. Try again."
- "Good boy."
- "Hurry!"
- "I'm sad when you leave."
- "You're a genius!"

### Turn-Taking

- Show clear states: listening, thinking, speaking, and microphone off.
- Allow interruption while the teacher is giving non-critical narration.
- Stop listening when the child taps microphone off or leaves the activity.
- Never record continuously in the background.
- When recognition confidence is low, say the app did not hear clearly rather
  than implying the child's reading was wrong.
- Always provide an equivalent touch response where practical.

### Sound Production

- Use expert-reviewed recordings for isolated phonemes.
- Avoid adding a schwa to consonants, such as saying `/muh/` for `/m/`.
- Synchronize phoneme audio with highlighting or tile movement.
- Let the child replay at normal and slower speeds.
- Test output on device speakers and common children's headphones.

## 8. Visual Language

### Overall Tone

Use a warm, adventurous natural world rather than a classroom worksheet. Themes
may include dragons, giant creatures, animals, dinosaurs, forests, food labs,
science expeditions, and math puzzles. Fictional creatures must be original and
must not imitate protected characters.

The base interface should remain calm:

- Light warm neutral backgrounds.
- Dark, high-contrast text.
- A small palette of saturated accent colors.
- Rounded but not infantile shapes.
- Texture and illustration around the task, never behind reading text.

### Color Roles

Define semantic design tokens rather than hard-coded feature colors:

- `surfacePrimary`: Main calm background.
- `surfaceRaised`: Cards and movable materials.
- `textPrimary`: Instructional and reading text.
- `actionPrimary`: The current primary action.
- `listening`: Active microphone state.
- `focusSound`: Current grapheme or phoneme.
- `success`: Completed action, used briefly.
- `attention`: Parent-facing warning or review state.

Do not encode correctness, phoneme identity, or navigation by color alone.
Avoid red in child feedback except where naturally part of an illustration.

### Typography

- Use a highly legible sans-serif with single-storey forms only if expert and
  child testing shows they improve recognition; otherwise prefer the native
  system font for consistency and accessibility.
- Keep letterforms stable across activities.
- Avoid all caps and decorative fonts for instructional text.
- Child reading text should generally be at least 28 pt on iPhone and 34 pt on
  iPad, then validated at real viewing distance.
- Use generous line height and spacing, but do not artificially separate the
  letters within a word.
- Keep lines short and prevent target words from wrapping.
- Parent mode honors Dynamic Type without truncating essential information.

### Layout and Touch

- Design for portrait iPhone and both common iPad orientations.
- Use a centered maximum content width on iPad rather than stretching tasks.
- Minimum interactive target: 52 x 52 pt in child mode.
- Leave generous spacing between draggable or tappable answers.
- Make drag targets forgiving and snap items into place.
- Keep primary controls in stable positions across activities.
- Protect system gestures and device safe areas.

### Illustration

- Illustrations create context, choice, and delight.
- They must not reveal the answer to a decoding task through obvious picture
  cues before the child attempts the word.
- Keep characters emotionally readable but not visually frantic.
- Represent diverse children and families without assigning ability stereotypes.
- Avoid frightening realism, graphic conflict, or intense peril.
- Maintain an asset review checklist for age appropriateness and licensing.

### Motion and Haptics

- Use motion to explain causality: a tile snaps to a sound box, sounds blend
  into a word, or a toy assembles from earned parts.
- Keep reward animations brief and skippable.
- Avoid idle motion around reading text.
- Do not use flashing, confetti storms, screen shake, or rapid particle effects.
- Honor Reduce Motion and provide a crossfade or static equivalent.
- Use light haptics for pickup, placement, and completion, never for error.

## 9. Activity Design Patterns

### Sound Games

- Begin audio-first with no print when testing phonemic awareness.
- Limit initial answer choices to two or three.
- Replay must be available without penalty.
- Add print only when connecting the sound to a grapheme.

### Tracing

- Demonstrate stroke direction once, then let the child explore.
- Use broad forgiving paths and avoid precision scoring.
- Pair the movement with the sound, not primarily the letter name.
- Completion depends on meaningful coverage, not pixel-perfect conformity.

### Movable Letters and Word Building

- Keep tile orientation fixed and letterforms clear.
- Use one sound box per phoneme, including digraph handling defined by the
  curriculum.
- Let the child hear each sound by tapping a tile.
- In word chains, visually preserve unchanged letters and move only the changed
  sound where practical.

### Spoken Reading

- Present one uncluttered unit at a time: grapheme, word, phrase, or sentence.
- Start listening only after the prompt and visible cue.
- On uncertain recognition, offer replay or touch confirmation.
- Never show the raw speech transcript to the child as corrective feedback.

### Stories

- Clearly distinguish "You read" and "Teacher reads" portions through stable
  layout and narration cues, not color alone.
- Highlight text only in meaningful units and never bounce word by word.
- Let the child tap an untaught word for help.
- Pause sparingly for dialogic questions; preserve story flow.
- Repeated readings may offer different roles or questions.

### Scavenger Hunts

- Search for target sounds or graphemes, not objects that encourage guessing a
  printed word from a picture.
- Keep scenes sparse enough for visual scanning.
- Announce the learning goal before entering the scene.

### Role-Play

- Every choice should use or reinforce the target skill.
- Keep narrative branches shallow in the MVP.
- Let spoken imagination enrich the theme, but return gently to the task.
- Avoid false urgency and failure states.

## 10. Reward Design

### Virtual Toys

- Toys are earned through transparent progress, never random chance.
- Show what action contributed: practice effort, strategy use, or a verified
  mastery milestone.
- Toys can be explored briefly without becoming a separate
  attention-maximizing game.
- Previously earned toys cannot be lost.
- Avoid rarity tiers, limited-time items, currencies for purchase, or pressure
  to complete one more task.

### Real-World Reward

- The parent defines the reward and mastery milestone.
- The child sees understandable progress without a deadline.
- Only verified retained mastery can complete the milestone.
- The app celebrates completion, then asks the parent to handle the real-world
  reward.
- Never promise that the parent will provide an item before confirmation.

### Praise

Use informational feedback more often than generic praise:

- Name the strategy used.
- Notice persistence without glorifying struggle.
- Acknowledge independent correction.
- Avoid labels about intelligence or being "a good reader."
- Do not praise every tap; allow the activity itself to provide satisfaction.

## 11. Skill Check Design

- Frame it as an adventure that discovers which games fit today.
- Mix modalities and include early successes.
- Do not call it a test, level, grade, or score in child mode.
- Allow breaks and end early when evidence is sufficient.
- Do not show correct/incorrect totals.
- Distinguish "not heard," "not yet taught," "uncertain," and "incorrect."
- Parent results explain observed skills and the proposed starting point in
  plain language, with an option to review but not manually inflate mastery.

## 12. Parent Dashboard Design

- Lead with a short factual summary, not a composite score.
- Organize skill status as "Secure," "Growing," and "Needs support."
- Explain evidence, including whether responses were independent or prompted.
- Show error patterns with examples and one brief offline activity.
- Keep latency and confidence statistics available in details, not as headline
  judgments.
- Clearly label AI-generated content and its approval state.
- Make retention, export, and deletion controls understandable and reversible
  where possible.
- Avoid predictions about disability, grade placement, or future outcomes.

## 13. Accessibility and Inclusion

- Meet WCAG 2.2 AA where applicable to native interfaces.
- Test VoiceOver reading order and custom drag alternatives.
- Pair all audio instructions with optional visual text or demonstration.
- Pair visual feedback with sound or haptics when helpful.
- Support Reduce Motion, sufficient contrast, and device text settings.
- Avoid requiring sustained drag, precise tracing, or speech as the only input.
- Allow slower narration and repeated instructions without penalty.
- Design for variable speech, accents, missing teeth, background noise, and
  code-switching; uncertainty must not become a false error.
- Do not use gendered praise or assume family structure.

## 14. Safety and Privacy in the Interface

- Show the microphone state whenever audio capture is possible.
- Ask for microphone permission in parent mode with a plain-language reason.
- Keep external links, purchases, account settings, and generated-content
  approval behind the parental gate.
- Never ask the child for full name, address, school, contact details, secrets,
  photos, or family information.
- Redirect personal disclosures without probing and provide a parent-facing
  safety event only when policy requires it.
- Do not display ads, social feeds, public profiles, or user-to-user messaging.
- Let parents preview generated text and audio before publication to child mode.

## 15. Content and Microcopy Standards

- Use concrete verbs and short sentences.
- Introduce no more than one new term in an instruction.
- Prefer "sound" over technical terminology in child mode.
- Write at a comprehension level appropriate for age 7, while keeping decodable
  text constrained by the curriculum.
- Separate instructional copy, decodable content, and teacher-read content in
  the content model.
- Do not imply that effort guarantees an immediate correct answer.
- Avoid sarcasm, shame, competition, baby talk, and exaggerated enthusiasm.
- All reusable prompts require curriculum and voice review.

## 16. Design System Components

The initial design system should provide:

- `ChildPrimaryButton`
- `ChildChoiceCard`
- `PauseButton`
- `ReplayButton`
- `HelpButton`
- `ListeningIndicator`
- `TeacherSpeechBubble`
- `ReadingTextBlock`
- `SoundBox`
- `LetterTile`
- `TracingCanvas`
- `ToyProgress`
- `RewardReveal`
- `ParentSkillStatus`
- `ParentEvidenceRow`
- `StoryApprovalCard`
- `PrivacyControlRow`

Components own visual and accessibility behavior, but not curriculum or mastery
logic. Activity screens compose components from server-provided session steps.

## 17. Responsive Guidance

### iPhone

- Use portrait as the primary child experience.
- Keep choices to one or two columns.
- Keep the target word and response area above controls and keyboard surfaces.
- Avoid modal stacks during an active session.

### iPad

- Preserve the same interaction model with more breathing room.
- Use two-pane layouts in parent mode where useful.
- Keep child task content centered at a readable width.
- Do not add extra distractors merely because space is available.
- Support landscape for tabletop letter tiles and tracing.

## 18. Design Validation

Every major activity requires:

1. Curriculum review for instructional correctness.
2. Voice review for phoneme production and teacher tone.
3. Accessibility review with touch and non-speech alternatives.
4. Device testing on a supported iPhone and iPad.
5. Supervised observation with the target child.
6. Verification that errors trigger wait, hint, model, simplify correctly.
7. Verification that speech uncertainty is communicated as a system limitation.
8. Review for cognitive load, accidental picture guessing, and reward pressure.

The key usability measures are whether the child can understand the next action,
request help, recover from an error, change activities, and stop without adult
navigation assistance.
