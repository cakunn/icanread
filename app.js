const story = [
  {
    text: "Max met a yak by the bus stop.",
    sightWords: ["a", "the"],
    focus: { word: "stop", chunks: "s | t | o | p", sounds: "/s/ /t/ /o/ /p/" }
  },
  {
    text: "The yak said, can pals share snacks?",
    sightWords: ["the", "said"],
    focus: { word: "share", chunks: "sh | ar | e", sounds: "/sh/ /ar/" }
  },
  {
    text: "Max and yak split a pack and sat to chat.",
    sightWords: ["a"],
    focus: { word: "split", chunks: "s | p | l | i | t", sounds: "/s/ /p/ /l/ /i/ /t/" }
  }
];

const warmup = ["cat", "mat", "red"];
let stage = "warmup";
let sentenceIndex = 0;
let stars = 0;
let needsSpotlight = [];

const el = {
  stageLabel: document.getElementById("stage-label"),
  promptTitle: document.getElementById("prompt-title"),
  content: document.getElementById("content"),
  actions: document.getElementById("actions"),
  progress: document.getElementById("progress-text"),
  stars: document.getElementById("stars-text")
};

function normalize(s) { return s.toLowerCase().replace(/[^a-z\s]/g, "").trim(); }

function render() {
  el.progress.textContent = `${sentenceIndex} / ${story.length} sentences`;
  el.stars.textContent = `⭐ ${stars} stars`;
  el.content.innerHTML = "";
  el.actions.innerHTML = "";

  if (stage === "warmup") {
    el.stageLabel.textContent = "Warm-up";
    el.promptTitle.textContent = "You already know these!";
    warmup.forEach((w) => {
      const span = document.createElement("span");
      span.className = "word-chip phonics";
      span.textContent = w;
      el.content.appendChild(span);
    });
    addButton("Start Story", () => { stage = "story"; render(); });
    return;
  }

  if (stage === "story") {
    el.stageLabel.textContent = "Story Round";
    const item = story[sentenceIndex];
    el.promptTitle.textContent = "Read this sentence out loud";

    const p = document.createElement("p");
    p.className = "sentence";
    p.textContent = item.text;
    el.content.appendChild(p);

    const sight = document.createElement("p");
    sight.innerHTML = `Snap words: ${item.sightWords.map((w) => `<span class='word-chip sight'>${w}</span>`).join(" ")}`;
    el.content.appendChild(sight);

    const input = document.createElement("input");
    input.type = "text";
    input.placeholder = "For MVP, type what the child said...";
    el.content.appendChild(input);

    addButton("Check Reading", () => evaluateAttempt(input.value));
    addButton("Skip", nextSentence, true);
    return;
  }

  if (stage === "spotlight") {
    el.stageLabel.textContent = "Word Spotlight";
    el.promptTitle.textContent = "Let's practice one tricky word";
    const focus = needsSpotlight[0];
    el.content.innerHTML = `<p class='sentence'><strong>${focus.word}</strong></p>
      <p class='word-chip phonics'>${focus.chunks}</p>
      <p>${focus.sounds}</p>`;
    addButton("Try Next Story Line", () => {
      needsSpotlight.shift();
      stage = sentenceIndex < story.length ? "story" : "recap";
      render();
    });
    return;
  }

  el.stageLabel.textContent = "Victory Recap";
  el.promptTitle.textContent = "Great reading today!";
  el.content.innerHTML = `<p>You finished ${story.length} story lines and earned <strong>${stars} stars</strong>.</p>
    <p>Best moment: You kept trying and used your sounds.</p>`;
  addButton("Restart Session", () => {
    stage = "warmup"; sentenceIndex = 0; stars = 0; needsSpotlight = []; render();
  }, true);
}

function evaluateAttempt(spoken) {
  const item = story[sentenceIndex];
  const expected = normalize(item.text);
  const got = normalize(spoken);
  const box = document.createElement("div");

  if (!got) {
    box.className = "feedback coach";
    box.textContent = "Nice trying. Let's read it together once, then try again.";
    el.content.appendChild(box);
    return;
  }

  if (got === expected) {
    stars += 1;
    box.className = "feedback success";
    box.textContent = "Great effort! You read it clearly. Let's go to the next line.";
    el.content.appendChild(box);
    addButton("Next Line", nextSentence, true);
    return;
  }

  stars += 1;
  needsSpotlight.push(item.focus);
  box.className = "feedback coach";
  box.textContent = `Great effort. Let's check one word: ${item.focus.word}. ${item.focus.chunks}. Now try again.`;
  el.content.appendChild(box);
  addButton("Practice Word", () => { stage = "spotlight"; render(); }, true);
}

function nextSentence() {
  sentenceIndex += 1;
  if (sentenceIndex >= story.length) {
    stage = needsSpotlight.length ? "spotlight" : "recap";
  }
  render();
}

function addButton(label, onClick, alt = false) {
  const btn = document.createElement("button");
  if (alt) btn.classList.add("alt");
  btn.textContent = label;
  btn.onclick = onClick;
  el.actions.appendChild(btn);
}

render();
