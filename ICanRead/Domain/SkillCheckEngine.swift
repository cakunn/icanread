import Foundation

enum SkillCheckFixture {
    static let curriculumVersion = "fixture-preview-2026-06-07"

    static func makeSession(childID: UUID, now: Date = .now) -> SkillCheckSession {
        SkillCheckSession(
            id: UUID(),
            childID: childID,
            curriculumVersion: curriculumVersion,
            status: .active,
            currentStepIndex: 0,
            supportLevel: .independent,
            attempts: [],
            startedAt: now,
            stepStartedAt: now,
            completedAt: nil,
            steps: [
                step(phoneme: "/m/", prompt: "Which letter matches the sound /m/?", choices: ["m", "s", "t"], expected: "m", familiar: true),
                step(phoneme: "/a/", prompt: "Which letter matches the middle sound /a/?", choices: ["i", "a", "m"], expected: "a"),
                step(phoneme: "/s/", prompt: "Find the letter for /s/.", choices: ["p", "t", "s"], expected: "s"),
                step(phoneme: "/t/", prompt: "Which letter matches /t/?", choices: ["m", "t", "i"], expected: "t")
            ]
        )
    }

    private static func step(
        phoneme: String,
        prompt: String,
        choices: [String],
        expected: String,
        familiar: Bool = false
    ) -> SkillCheckStep {
        SkillCheckStep(
            id: UUID(),
            phoneme: phoneme,
            prompt: prompt,
            choices: choices,
            expectedChoice: expected,
            familiar: familiar
        )
    }
}

enum SkillCheckEngine {
    static func record(
        selection: String?,
        modality: InputModality = .touch,
        in session: SkillCheckSession,
        now: Date = .now
    ) -> SkillCheckSession {
        guard session.status == .active, let step = session.currentStep else {
            return session
        }

        var updated = session
        let classification: ResponseClassification
        if let selection {
            classification = selection == step.expectedChoice ? .correct : .incorrect
        } else {
            classification = .unscored
        }

        updated.attempts.append(
            AttemptEvidence(
                id: UUID(),
                stepID: step.id,
                presentedPhoneme: step.phoneme,
                selectedResponse: selection,
                classification: classification,
                supportLevel: session.supportLevel,
                inputModality: modality,
                responseLatencyMilliseconds: max(0, Int(now.timeIntervalSince(session.stepStartedAt) * 1_000)),
                createdAt: now
            )
        )

        switch classification {
        case .correct:
            updated.currentStepIndex += 1
            updated.supportLevel = .independent
            updated.stepStartedAt = now
            if updated.currentStepIndex == updated.steps.count {
                updated.status = .completed
                updated.completedAt = now
            }
        case .incorrect:
            updated.supportLevel = session.supportLevel.next
        case .unscored:
            break
        }

        return updated
    }

    static func requestHelp(in session: SkillCheckSession) -> SkillCheckSession {
        guard session.status == .active else { return session }
        var updated = session
        updated.supportLevel = session.supportLevel.next
        return updated
    }

    static func pause(_ session: SkillCheckSession) -> SkillCheckSession {
        guard session.status == .active else { return session }
        var updated = session
        updated.status = .paused
        return updated
    }

    static func resume(_ session: SkillCheckSession, now: Date = .now) -> SkillCheckSession {
        guard session.status == .paused else { return session }
        var updated = session
        updated.status = .active
        updated.stepStartedAt = now
        return updated
    }

    static func summary(for session: SkillCheckSession) -> SkillCheckSummary {
        let correct = session.attempts.filter { $0.classification == .correct }
        return SkillCheckSummary(
            completedSteps: Set(correct.map(\.stepID)).count,
            independentResponses: correct.filter { $0.supportLevel == .independent }.count,
            supportedResponses: correct.filter { $0.supportLevel != .independent }.count,
            incorrectAttempts: session.attempts.filter { $0.classification == .incorrect }.count
        )
    }
}
