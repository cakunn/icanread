# Phonics Reading Game Plan (Age 7)

## Goal
Build a playful reading practice game where your child reads short, funny sentences out loud and gets warm, teacher-like feedback. The game should:
- Reinforce **phonics decoding** (sound-letter mapping).
- Handle **sight words** differently (recognition + memory).
- Celebrate success and track growth over time.
- Use silly micro-stories similar in feel to *The Fat Cat on a Mat*.

## Core Experience (What a session looks like)
1. **Warm-up (2 minutes)**
   - Show 3 familiar words from previous sessions.
   - Quick confidence wins (“You already know these!”).

2. **Story round (5–10 minutes)**
   - Show one short, silly sentence at a time.
   - Child reads aloud.
   - AI listens and gives immediate feedback:
     - Praise first.
     - Correct gently.
     - Model decoding when needed.

3. **Word spotlight (1–2 minutes)**
   - Pick 1–2 tricky words from that round.
   - Decompose into phonics chunks.
   - Re-read in sentence.

4. **Victory recap (1 minute)**
   - Show words read correctly.
   - Award stars/badges.
   - End with positive teacher-style message.

---

## Feedback Style (Natural, Encouraging, Teacher-like)
Use this pattern every turn:
1. **Celebrate effort**: “Nice try! I love how carefully you read.”
2. **Name what was correct**: “You got *cat* and *mat* right away!”
3. **Teach one small thing**:
   - Phonics word: “Let’s sound out **bird**: **/b/ - /ir/ - /d/**. Now blend: **bird**.”
   - Sight word: “This is a snap word: **the**. We remember it fast.”
4. **Retry**: “Can you read the sentence one more time?”
5. **Big close**: “Yes! You fixed it—great reader thinking!”

### Tone rules
- Keep feedback short (1–3 sentences).
- Never shame mistakes.
- Focus on one correction at a time.
- Always end with success language.

---

## Word Types and Visual Design

### A) Decodable / phonics words
Display with optional segment view when child struggles:
- Normal: `bird`
- Segmented: `b | ir | d`
- Sound cues: `/b/ /ir/ /d/`

Other examples:
- `ship` → `sh | i | p`
- `black` → `bl | a | ck`
- `jumped` → `j | u | m | p | t` (spoken as sounds)

### B) Sight words
Use a different visual treatment so the child knows these are memory words:
- Put sight words in a **highlight color** or **rounded chip**.
- Add icon label: “👀 Snap Word”.
- Keep a rotating wall of mastered sight words.

Examples: `the`, `was`, `said`, `come`, `you`

---

## Scoring and Motivation
Track progress at both sentence and word level.

### Per-sentence metrics
- Sentence read correctly (yes/no)
- Number of words correct on first try
- Number corrected after feedback

### Per-word metrics
For each word, store:
- Attempts
- Correct on first attempt
- Correct after prompt
- Last seen date
- Mastery level (New → Practicing → Strong)

### Rewards
- 1 star for finishing a sentence.
- Bonus star for correcting a word after coaching.
- “Bravery badge” for trying hard words.
- “Phonics detective badge” for blending sounds successfully.

Use rewards to praise growth, not speed.

---

## Suggested Data Model (simple)
- **ChildProfile**: name, age, interests, preferred praise style
- **WordRecord**: word, type (phonics/sight), stats, mastery
- **SentenceRecord**: sentence text, word list, attempts, success
- **SessionRecord**: date, total stars, words practiced, funny story used

---

## Example Funny Micro-Stories (Level-appropriate)
Keep lines short, predictable, and silly. Alternate themes so stories build both reading skills and character strengths.

### Story 1 (Friendship)
1. “Max met a yak by the bus stop.”
2. “The yak said, ‘Can pals share snacks?’”
3. “Max and yak split a pack and sat to chat.”

### Story 2 (Kindness)
1. “Nia saw a wet pup in the rain.”
2. “She set out a cup and a soft red rag.”
3. “The pup gave Nia a big tail wag.”

### Story 3 (Curiosity)
1. “Ben found a box with a tiny lock.”
2. “He said, ‘Hmm… what can this be?’”
3. “It held a map of the park and a duck.”

### Story 4 (Helpfulness)
1. “Dot the robot had a lot to lug.”
2. “Tim said, ‘I can help with that tub!’”
3. “Dot beeped, ‘Thanks, pal!’ and did a happy spin.”

### Story 5 (Perseverance)
1. “Liv tried to hop on one leg and slip-kicked a sock.”
2. “She fell, then stood, then tried again.”
3. “At last, Liv did ten hops and grinned.”

### Story 6 (Courage)
1. “A kid named Jo heard a thump in the shed.”
2. “Jo took a breath and checked with a light.”
3. “It was just a cat in Dad’s old hat.”

### Story 7 (Politeness + Respect)
1. “At lunch, Raj said, ‘May I have jam, please?’”
2. “Kim said, ‘Yes, and thanks for asking nice.’”
3. “They both said, ‘You’re welcome,’ with smiles.”

### Story 8 (Problem Solving + Growth)
1. “Mia’s kite got stuck up high in a tree.”
2. “She made a plan: stick + string + hook.”
3. “The kite slid down, and Mia said, ‘I learned a new trick!’”

### Story 9 (Bravery + Caring)
1. “Zed heard peeps from a box by the gate.”
2. “He felt scared, but he still took a look.”
3. “Two chicks were cold, so Zed got a warm crate.”

### Story 10 (Openness + Understanding)
1. “Ana liked bats; Lee liked frogs.”
2. “They said, ‘Let’s swap facts and learn both!’”
3. “Now they cheer for bats and frogs at dusk.”

---

## Example Feedback Snippets

### If mostly correct
“You read that so smoothly! You got every word in the sentence. High five, reader!”

### If one phonics error
“Great effort. Let’s check one word: **bird**. Say the sounds with me: **/b/ - /ir/ - /d/**. Blend it: **bird**. Now try the whole sentence again.”

### If sight word confusion
“Nice trying! This word is a snap word: **the**. We remember it quickly. Can you point to **the** and read the sentence again?”

### If child self-corrects
“You fixed it yourself—that is what strong readers do!”

---

## 6-Week Rollout Plan

### Weeks 1–2: Confidence + routine
- 5–8 minute sessions.
- Reuse known patterns (cat/mat/sat).
- Introduce reward screen.

### Weeks 3–4: Add complexity slowly
- Mix CVC words with digraphs (`sh`, `ch`, `th`).
- Introduce 3–5 sight words in rotation.
- Start “word spotlight” review.

### Weeks 5–6: Build stamina + independence
- Slightly longer mini-stories.
- Ask child to choose next story theme.
- Add “read it with expression” bonus.

---

## Parent Dashboard Ideas
Simple, encouraging summaries:
- “Words mastered this week: 12”
- “Top confidence words: cat, mat, red, bird”
- “Needs gentle review: was, said, shirt”
- “Best moment: self-corrected ‘bird’ after blending sounds”

Avoid red/error-heavy screens; focus on growth trends.

---

## Implementation Checklist
- [ ] Create word bank tagged as `phonics` or `sight`
- [ ] Build sentence generator for short silly lines
- [ ] Add speech recognition pipeline for child voice
- [ ] Add word-by-word comparison with confidence scores
- [ ] Build feedback engine (praise → teach → retry)
- [ ] Add phonics decomposition renderer
- [ ] Add sight-word visual highlighter
- [ ] Save per-word mastery stats
- [ ] Build stars/badges and session recap
- [ ] Add parent progress view

## Safety and UX Notes
- Keep sessions short to avoid fatigue.
- Allow manual override when speech recognition misses a correct reading.
- Include “repeat sentence” button and slower read-aloud option.
- Protect child data with minimal storage and clear privacy settings.
