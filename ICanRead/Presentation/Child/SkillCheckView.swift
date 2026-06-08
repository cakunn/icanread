import SwiftData
import SwiftUI

struct SkillCheckView: View {
    let profile: ChildProfile
    let onExit: () -> Void

    @Environment(\.modelContext) private var modelContext
    @Query private var records: [AppLearningSessionRecord]
    @State private var session: SkillCheckSession?
    @State private var showingPause = false
    @State private var feedback: String?
    @State private var audioPlayer = PreviewPhonemeAudioPlayer()

    var body: some View {
        ZStack {
            DesignTokens.surfacePrimary.ignoresSafeArea()
            if let session {
                if session.isComplete {
                    completion(session)
                } else if let step = session.currentStep {
                    activity(session: session, step: step)
                }
            } else {
                ProgressView("Preparing the sound adventure...")
            }
        }
        .task { loadOrCreateSession() }
        .sheet(isPresented: $showingPause) {
            pauseSheet
                .presentationDetents([.medium])
        }
    }

    private func activity(session: SkillCheckSession, step: SkillCheckStep) -> some View {
        ScrollView {
            VStack(spacing: 22) {
                HStack {
                    roundControl(title: "Pause", symbol: "pause.fill") {
                        update(SkillCheckEngine.pause(session))
                        showingPause = true
                    }
                    Spacer()
                    Text("Sound adventure")
                        .font(.title2.bold())
                    Spacer()
                    roundControl(title: "Replay", symbol: "arrow.clockwise") {
                        audioPlayer.play(
                            step.phoneme,
                            slower: profile.accessibilityPreferences.slowerTeacherVoice
                        )
                    }
                }

                Text("UNVERIFIED FIXTURE PREVIEW")
                    .font(.caption.bold())
                    .tracking(1)
                    .foregroundStyle(DesignTokens.textPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(DesignTokens.attention.opacity(0.22), in: Capsule())

                VStack(spacing: 10) {
                    Image(systemName: themeSymbol)
                        .font(.system(size: 52))
                        .foregroundStyle(DesignTokens.actionPrimary)
                    Text(supportPrompt(for: session.supportLevel, step: step))
                        .font(.title2.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .accessibilityLabel("Teacher says: \(supportPrompt(for: session.supportLevel, step: step))")
                }
                .padding(22)
                .frame(maxWidth: 580)
                .background(.white, in: RoundedRectangle(cornerRadius: 24))
                .shadow(color: DesignTokens.shadow, radius: 10, y: 5)

                Text("Turn \(session.currentStepIndex + 1) of \(session.steps.count)")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                HStack(spacing: 16) {
                    ForEach(visibleChoices(for: session, step: step), id: \.self) { choice in
                        Button {
                            choose(choice, in: session)
                        } label: {
                            Text(choice)
                                .font(.system(size: 62, weight: .bold, design: .rounded))
                                .foregroundStyle(DesignTokens.textPrimary)
                                .frame(maxWidth: .infinity, minHeight: 132)
                                .background(
                                    LinearGradient(
                                        colors: [.white, Color(red: 0.91, green: 0.82, blue: 0.64)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ),
                                    in: RoundedRectangle(cornerRadius: 24)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(DesignTokens.focusSound.opacity(0.45), lineWidth: 3)
                                }
                                .shadow(color: DesignTokens.shadow, radius: 7, y: 4)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("Choose letter \(choice)")
                    }
                }
                .frame(maxWidth: 680)

                if let feedback {
                    Text(feedback)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: 580)
                        .background(DesignTokens.success.opacity(0.15), in: RoundedRectangle(cornerRadius: 16))
                }

                Button {
                    feedback = nil
                    update(SkillCheckEngine.requestHelp(in: session))
                } label: {
                    Label("Help me", systemImage: "questionmark.circle.fill")
                        .font(.title3.bold())
                        .frame(minWidth: 180, minHeight: 56)
                }
                .buttonStyle(.bordered)
                .tint(DesignTokens.actionPrimary)
            }
            .padding(22)
            .frame(maxWidth: 760)
            .frame(maxWidth: .infinity)
        }
    }

    private func completion(_ session: SkillCheckSession) -> some View {
        let summary = SkillCheckEngine.summary(for: session)
        return VStack(spacing: 24) {
            Image(systemName: "leaf.circle.fill")
                .font(.system(size: 82))
                .foregroundStyle(DesignTokens.success)
            Text("Sound adventure complete")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            Text("You listened, made choices, and used clues when you needed them.")
                .font(.title2)
                .multilineTextAlignment(.center)
            Text("\(summary.completedSteps) sound turns explored")
                .font(.headline)
                .padding()
                .background(.white, in: Capsule())
            Text("This preview does not give a score or mark a skill mastered.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Button("Back to home", action: onExit)
                .buttonStyle(ChildPrimaryButtonStyle())
                .frame(maxWidth: 420)
        }
        .padding(28)
    }

    private var pauseSheet: some View {
        VStack(spacing: 22) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: 52))
                .foregroundStyle(DesignTokens.actionPrimary)
            Text("Take a quiet break")
                .font(.largeTitle.bold())
            Text("Your place is saved.")
                .font(.title3)
                .foregroundStyle(.secondary)
            Button("Keep going") {
                if let session {
                    update(SkillCheckEngine.resume(session))
                }
                showingPause = false
            }
            .buttonStyle(ChildPrimaryButtonStyle())
            Button("I'm done for now") {
                showingPause = false
                onExit()
            }
            .font(.headline)
            .frame(minHeight: 52)
        }
        .padding(28)
    }

    private func roundControl(title: String, symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: symbol)
                    .font(.title2.bold())
                    .frame(width: 54, height: 54)
                    .background(.white, in: Circle())
                    .shadow(color: DesignTokens.shadow, radius: 5, y: 3)
                Text(title).font(.caption.bold())
            }
            .foregroundStyle(DesignTokens.actionPrimary)
        }
        .buttonStyle(.plain)
    }

    private func supportPrompt(for level: SupportLevel, step: SkillCheckStep) -> String {
        switch level {
        case .independent: step.prompt
        case .hinted: "Listen again. The sound is \(step.phoneme)."
        case .modeled: "Watch me: \(step.phoneme) matches \(step.expectedChoice). Try it with me."
        case .simplified: "Choose between these two letters for \(step.phoneme)."
        }
    }

    private func visibleChoices(for session: SkillCheckSession, step: SkillCheckStep) -> [String] {
        guard session.supportLevel == .simplified else { return step.choices }
        let distractor = step.choices.first { $0 != step.expectedChoice }
        return [step.expectedChoice, distractor].compactMap { $0 }.sorted()
    }

    private var themeSymbol: String {
        profile.interests.first?.symbol ?? "leaf.fill"
    }

    private func choose(_ choice: String, in current: SkillCheckSession) {
        let wasCorrect = choice == current.currentStep?.expectedChoice
        feedback = wasCorrect ? "You matched the sound." : "That choice gives us information. Here is a smaller clue."
        let updated = SkillCheckEngine.record(selection: choice, in: current)
        update(updated)
        if wasCorrect, !updated.isComplete {
            feedback = nil
        }
    }

    private func loadOrCreateSession() {
        if let saved = records
            .compactMap(\.domainModel)
            .filter({ $0.childID == profile.id && !$0.isComplete })
            .sorted(by: { $0.startedAt > $1.startedAt })
            .first {
            session = SkillCheckEngine.resume(saved)
            if let session { persist(session) }
        } else {
            let created = SkillCheckFixture.makeSession(childID: profile.id)
            session = created
            persist(created)
        }
    }

    private func update(_ updated: SkillCheckSession) {
        session = updated
        persist(updated)
    }

    private func persist(_ session: SkillCheckSession) {
        if let record = records.first(where: { $0.id == session.id }) {
            record.update(from: session)
        } else {
            modelContext.insert(AppLearningSessionRecord(session: session))
        }
        try? modelContext.save()
    }
}
