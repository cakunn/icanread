# I Can Read - Product Requirements Document

## 1. Product Summary

I Can Read is an iPhone and iPad reading tutor for one early reader who knows
letter sounds and can decode simple words, but does so slowly and with low
confidence. The child has difficulty quickly recalling sounds, blending,
retaining recently read words, reading fluently, spelling, and consistently
hearing or representing middle sounds.

The product combines a structured phonics progression with Montessori-informed
choice, short playful activities, multimodal instruction, and a warm female
voice. It is designed for regular family use and should be architected so it
can later become a commercial multi-family product.

The app supplements involved adults and qualified educators. It does not
diagnose or treat dyslexia, speech-language disorders, or other learning needs.

## 2. Product Principles

1. **Structured skills, child-led experience.** The app determines what skill
   should be practiced, while the child chooses the theme and activity.
2. **Sounds before memorization.** Explicit phonemic awareness and phonics are
   the foundation. Irregular high-frequency words are taught by identifying
   the regular and unexpected sound-spelling parts, not as visual guessing.
3. **Encoding supports decoding.** Word building and spelling appear alongside,
   and often before, reading the same patterns.
4. **Concrete before abstract.** Activities move from listening and manipulating
   sounds and tiles to reading printed words and connected text.
5. **Observe before intervening.** Help follows the sequence: wait, hint, model,
   simplify.
6. **Effort without pressure.** Reward persistence, strategy use, and mastery.
   Do not use streaks, countdown pressure, comparison, or speed leaderboards.
7. **Short and joyful.** A session is designed for 10-15 minutes, can continue
   up to the child's natural 15-20 minute tolerance, and can end at any time.
8. **AI assists; curriculum controls.** Generative AI may personalize stories
   and conversation, but it must not decide skill mastery or invent phonics
   instruction outside the approved curriculum.
9. **The parent stays in control.** Parents approve generated stories and can
   review or delete recordings and child data.

## 3. Goals

### MVP Goals

- Improve automatic recall of taught letter-sound correspondences.
- Improve phoneme segmentation and blending, especially medial sounds.
- Build confidence reading short decodable words and sentences.
- Connect spelling, word building, reading, and meaning.
- Increase willingness to begin and complete short reading sessions.
- Give the parent clear evidence of progress and actionable offline activities.
- Provide reliable voice input and a clear, warm female teaching voice.

### Non-Goals

- Diagnosing reading disabilities or replacing a teacher, reading specialist,
  speech-language pathologist, or clinician.
- Teaching through picture or context guessing.
- A complete K-5 literacy curriculum in the MVP.
- Classrooms, teacher rosters, multiple child profiles, social features, or
  competitive leaderboards.
- Fully autonomous, unrestricted child conversations with an AI.
- Offline speech recognition or narration.
- Parent notifications, weekly assignments, streaks, or fixed deadlines.

## 4. Primary Users

### Child

- Age: 7
- Reads simple CVC words and short sentences slowly.
- Knows letter sounds but recall is slow and uncertain.
- Attempts to decode high-frequency words instead of recalling their taught
  sound-spelling structure.
- May omit middle sounds in speech-to-print tasks.
- Becomes frustrated by long words.
- Can engage for approximately 15-20 minutes.
- Interests include dragons, Godzilla-like giant monsters, animals, dinosaurs,
  nature, food, science, and math.
- Enjoys playful activities and collecting toys.

### Parent

- Sets up and supervises the account.
- Reviews progress, error patterns, recordings, and generated content.
- Records optional narration and encouragement.
- Defines a real-world reward associated with a meaningful mastery milestone.

## 5. Core Experience

### 5.1 Parent Onboarding

The parent:

1. Creates an adult account and passes a parental gate.
2. Creates one child profile with first name, age, interests, and optional
   accessibility preferences.
3. Reviews consent and data controls for microphone use, recordings, AI
   processing, and generated content.
4. Chooses whether audio may be retained for dashboard playback. The default is
   not to retain raw audio after processing.
5. Optionally records short encouragement clips.
6. Defines a future real-world reward and the mastery milestone that earns it.

### 5.2 Playful Skill Check

The first child experience is a low-pressure adventure, not a test. It samples:

- Phoneme identification and discrimination.
- Letter-sound recall.
- Initial, final, and medial sound identification.
- Oral blending and segmentation.
- Reading regular CVC words.
- Encoding CVC words with movable tiles.
- A small set of high-frequency words with regular and irregular parts.
- Reading a short decodable sentence and answering a meaning question.

Rules:

- Stop or shorten when frustration or fatigue is detected.
- Never display a score to the child.
- Use enough items to establish a starting point, not to exhaust every skill.
- Record uncertainty separately from incorrect answers.
- Let the parent review the resulting starting placement.

Current implementation note: the native debug build includes a four-turn
touch-only fixture preview of this interaction model. Its prompts, audio, and
evidence are visibly marked unreviewed; it does not produce placement or
mastery.

### 5.3 Session Loop

Each session follows this structure:

1. **Warm welcome:** The teacher offers two or three theme choices.
2. **Child choice:** The child chooses a theme and one of the eligible activity
   formats by touch or voice.
3. **Quick success:** Begin with a recently mastered item.
4. **Focused practice:** Work on one primary skill using several modalities.
5. **Apply the skill:** Use it in word building, a sentence, or a short story.
6. **Meaning check:** Include one conversational comprehension prompt.
7. **Reflection and reward:** Recognize effort or strategy, award progress
   toward a virtual toy, and offer stop or continue.

The child can always say or tap:

- "Help me."
- "Say it again."
- "Change activity."
- "Take a break."
- "I'm done."

### 5.4 Adaptive Help

For each response, the tutor uses:

1. **Wait:** Allow unhurried thinking time without filling silence.
2. **Hint:** Give the smallest relevant cue, such as isolating a sound or
   highlighting the grapheme.
3. **Model:** Demonstrate the sound or blending process and invite a retry.
4. **Simplify:** Reduce the number of sounds, return to tiles, or present an
   easier contrast. Revisit the original item later.

The app must not repeatedly demand a correct response after visible or audible
frustration. It should preserve dignity, offer a success, and move on.

### 5.5 Activity Types

The MVP includes:

- **Sound games:** Hear, identify, match, blend, and segment phonemes.
- **Letter tracing:** Trace an on-screen grapheme while hearing and saying its
  sound. Accuracy is encouraging rather than punitive.
- **Movable letters:** Drag tiles to encode spoken words.
- **Word building:** Change one phoneme at a time to create word chains.
- **Spoken reading:** Read a sound, word, phrase, or sentence aloud.
- **Illustrated decodable stories:** Read child-decodable text with optional
  teacher read-aloud for untaught words.
- **Scavenger hunts:** Find sounds, graphemes, or words in a playful scene.
- **Role-play adventures:** Use target words to help a character solve a
  problem.

Activities are data-driven so new themes can reuse validated learning mechanics.

### 5.6 Stories

The app provides:

- A curated, expert-reviewed library of decodable stories.
- AI-generated personalized stories based on approved interests and the current
  phonics constraints.
- Optional use of the child's first name; all other content is fictional unless
  explicitly entered and approved by the parent.
- Parent approval before any generated story appears in child mode.
- A clear distinction between text the child is expected to decode and richer
  text the teacher reads aloud.
- Dialogic prompts for prediction, feelings, causal reasoning, retelling, and
  connections to prior knowledge.

Generated content must pass automated checks for safety, age appropriateness,
target grapheme coverage, untaught spelling patterns, vocabulary difficulty,
and prohibited commercial characters or copyrighted story imitation.

### 5.7 Rewards

- The child earns parts, tokens, or accessories for a virtual toy collection.
- Small rewards recognize effort, persistence, asking for help, and using a
  taught strategy.
- Mastery rewards require evidence across multiple items, contexts, and
  sessions, not one successful attempt.
- A parent-defined real-world reward unlocks only at a meaningful milestone.
- The parent confirms fulfillment outside the child experience.
- There are no streaks, loot boxes, variable-ratio purchases, loss mechanics,
  ads, or manipulative scarcity.

## 6. Curriculum and Adaptation

### 6.1 Initial Sequence

Final content should be reviewed by a qualified literacy expert. The system must
support a progression broadly shaped as:

1. Phonemic awareness without print.
2. A small set of high-utility, visually distinct sound-spelling mappings.
3. Continuous-sound oral blending where possible.
4. CVC encoding and decoding.
5. Explicit attention to medial vowels.
6. Cumulative review and mixed practice.
7. Word chains and simple phrases.
8. Common digraphs and adjacent consonants.
9. Longer words taught through syllable-aware chunking.
10. High-frequency words mapped by regular and unexpected parts.

### 6.2 Skill Model

Each skill tracks:

- First exposure and practice count.
- Independent, hinted, modeled, and incorrect responses.
- Response latency as a diagnostic signal, never a child-facing score.
- Performance by activity modality.
- Recent error patterns and likely confusions.
- Retention after increasing intervals.
- Transfer to new words and connected text.

The next activity selection considers:

- Curriculum prerequisites.
- Current confidence estimate.
- Recent and spaced review needs.
- Error patterns, especially omitted medial phonemes.
- Child choice, interest, fatigue, and frustration.

### 6.3 Mastery

A skill is mastered only when the child demonstrates:

- Accuracy across multiple examples.
- At least two activity modalities where applicable.
- Independent responses rather than modeled repetitions.
- Retention in a later session.
- Transfer to at least one unfamiliar example.

The exact thresholds are configurable curriculum data and must be validated
during parent testing and expert review.

## 7. Voice and Teacher Behavior

### Voice Requirements

- General American English.
- High-quality, clear, warm female voice.
- Child-directed but not babyish.
- Slightly slower speech with natural prosody and clean phoneme production.
- Replay at normal or slower speed.
- Low-latency turn-taking and interruption handling.
- Visible listening state and an obvious microphone-off control.

Speech recognition must distinguish:

- No response.
- Environmental noise.
- Uncertain recognition.
- A plausible child pronunciation.
- A clear target or non-target response.

Low recognition confidence must trigger a retry or alternate touch response, not
mark the child wrong. Critical phoneme scoring must use constrained expected
answers and purpose-built pronunciation logic rather than an unrestricted
language-model judgment.

### Teacher Behavior

The teacher:

- Supports relevant open-ended questions and storytelling.
- Gently connects conversation back to the learning goal.
- Follows child interests when they can support the current skill.
- Uses brief directions and one prompt at a time.
- Avoids shame, comparison, false claims, excessive praise, and praise for
  speed.
- Does not claim to be human, a friend who needs the child, or a replacement
  for a parent or teacher.
- Redirects requests outside the bounded child experience.

## 8. Parent Dashboard

The dashboard shows:

- Current curriculum position and skills mastered.
- Skills in progress and confidence trends.
- Recurring error patterns, such as omitted medial sounds.
- Session summaries with activity, duration, support level, and engagement.
- Selected recordings when retention was explicitly enabled.
- Approved and pending generated stories.
- Suggested short offline activities tied to observed needs.
- Virtual toy progress and mastery milestones.
- Controls to edit interests, record audio, export data, and delete recordings,
  stories, or the account.

It does not send weekly plans or notifications in the MVP.

## 9. Safety, Privacy, and Trust

Because the product is directed to a child under 13:

- The adult is the account holder and consent authority.
- Collect only data required to provide the service.
- Do not use child data, audio, or generated content for advertising or model
  training.
- Default to transient audio processing; retain recordings only with granular
  parent opt-in.
- Encrypt data in transit and at rest.
- Keep child mode free of external links, purchases, chat with other users, and
  unapproved generated content.
- Put account, consent, reward configuration, deletion, and story approval
  behind a parental gate.
- Maintain auditable consent and deletion records.
- Provide parent-accessible export and deletion.
- Set and enforce short retention periods for operational logs.
- Complete legal review for COPPA and applicable state privacy requirements
  before any commercial release.

## 10. Functional Requirements

### P0: Required for MVP

- Native iPhone and iPad child experience.
- Parent onboarding and one child profile.
- Playful skill check and parent-visible placement.
- Structured curriculum and adaptive skill selection.
- All eight core activity formats, with at least one reusable template each.
- Touch and voice input.
- High-quality teacher narration and bounded conversation.
- Adaptive wait, hint, model, simplify support.
- Curated stories and parent-approved generated stories.
- Parent-recorded encouragement and narration.
- Virtual toy collection and parent-defined milestone reward.
- Parent dashboard and data deletion controls.
- Instrumentation for learning outcomes, reliability, cost, and safety.

### P1: Important Follow-Up

- More activity variants and content packs.
- Improved pronunciation assessment from real usage data.
- Additional voices and accessibility controls.
- Parent-authored word lists and custom stories.
- Multiple child profiles and subscriptions.

### P2: Future Commercial Expansion

- Android.
- Educator accounts and classroom tools.
- Additional English dialects and languages.
- Downloadable lesson packs and selected offline support.

## 11. Accessibility

- Support Dynamic Type in parent mode and large, stable text in child mode.
- Do not rely on color alone.
- Provide captions or visual reinforcement for spoken instructions.
- Use large touch targets and forgiving drag-and-drop interactions.
- Avoid unnecessary motion; honor Reduce Motion.
- Keep screens visually calm with one primary task.
- Allow narration replay and adjustable speaking rate.

## 12. Success Metrics

### Learning

- Increased independent accuracy on targeted sound-spelling mappings.
- Increased inclusion of medial phonemes in segmentation and encoding.
- Improved independent blending across unfamiliar decodable words.
- Retention of mastered skills after spaced delays.
- Increased proportion of connected text read without help.

### Engagement

- Child voluntarily starts or agrees to sessions.
- Sessions commonly reach 10 minutes without escalating frustration.
- Child uses help, activity choice, and stop controls appropriately.
- Return use without streaks or pressure mechanics.

### Product Quality

- Voice response latency feels conversational.
- Speech recognition uncertainty rarely becomes false negative feedback.
- No unapproved generated story is visible in child mode.
- Parent can understand why a skill is being practiced.
- AI and speech cost remains within an explicit per-session budget.

No metric should optimize time in app at the expense of learning, autonomy, or
well-being.

## 13. MVP Acceptance Criteria

The MVP is ready for regular family use when:

1. A parent can set up one child and complete consent without developer help.
2. The child can complete the skill check by touch and voice.
3. The app selects an appropriate starting skill and explains it to the parent.
4. A child can complete a 10-15 minute session across at least three activity
   formats without navigation assistance.
5. Voice uncertainty never silently becomes an incorrect learning record.
6. The tutor consistently follows wait, hint, model, simplify.
7. Mastery requires independent retained evidence.
8. Generated stories remain unavailable until parent approval.
9. The parent can see progress, errors, summaries, selected recordings, and
   offline recommendations.
10. The parent can delete audio and all account data.
11. App crashes, blocked lesson flows, and content-safety violations are absent
    from the release test suite.

## 14. Validation Plan

Before broad release:

1. Review the phonics scope, sequence, prompts, and mastery rules with a
   qualified structured-literacy specialist.
2. Conduct supervised usability sessions with the target child.
3. Compare speech judgments against parent or expert labels, emphasizing
   false-negative rates.
4. Observe whether the child understands choice, help, break, and stop controls.
5. Review all safety, consent, retention, and deletion flows with counsel.
6. Run generated-content red-team tests and manually review output samples.
