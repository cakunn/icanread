import Foundation

struct ParentSession: Equatable, Sendable {
    let parentID: UUID
    let authenticationMethod: AuthenticationMethod
}

enum AuthenticationMethod: String, Codable, Sendable {
    case signInWithApple
    case debugFixture
}

struct ChildProfile: Equatable, Sendable {
    let id: UUID
    var firstName: String
    var age: Int
    var interests: [Interest]
    var accessibilityPreferences: AccessibilityPreferences
    var consent: ConsentRecord
    var setupComplete: Bool

    var setupDraft: SetupDraft {
        SetupDraft(
            firstName: firstName,
            age: age,
            interests: Set(interests),
            accessibilityPreferences: accessibilityPreferences,
            consent: consent
        )
    }
}

struct SetupDraft: Equatable, Sendable {
    var firstName: String
    var age: Int
    var interests: Set<Interest>
    var accessibilityPreferences: AccessibilityPreferences
    var consent: ConsentRecord

    static let empty = SetupDraft(
        firstName: "",
        age: 7,
        interests: [],
        accessibilityPreferences: .default,
        consent: .empty
    )

    var canComplete: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !interests.isEmpty
            && consent.requiredConsentsAccepted
    }
}

enum Interest: String, Codable, CaseIterable, Identifiable, Sendable {
    case dragons
    case giantCreatures = "Giant creatures"
    case animals
    case dinosaurs
    case nature
    case food
    case science
    case math

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .dragons: "flame.fill"
        case .giantCreatures: "figure.strengthtraining.traditional"
        case .animals: "pawprint.fill"
        case .dinosaurs: "fossil.shell.fill"
        case .nature: "leaf.fill"
        case .food: "fork.knife"
        case .science: "atom"
        case .math: "sum"
        }
    }
}

struct AccessibilityPreferences: Codable, Equatable, Sendable {
    var slowerTeacherVoice: Bool
    var reducedMotion: Bool
    var captionsEnabled: Bool

    static let `default` = AccessibilityPreferences(
        slowerTeacherVoice: false,
        reducedMotion: false,
        captionsEnabled: true
    )
}

struct ConsentRecord: Codable, Equatable, Sendable {
    var microphoneProcessing: Bool
    var cloudAIProcessing: Bool
    var retainSelectedAudio: Bool
    var acceptedAt: Date?

    static let empty = ConsentRecord(
        microphoneProcessing: false,
        cloudAIProcessing: false,
        retainSelectedAudio: false,
        acceptedAt: nil
    )

    var requiredConsentsAccepted: Bool {
        microphoneProcessing && cloudAIProcessing
    }
}

enum AppCapability: String, CaseIterable, Sendable {
    case parentSetup
    case localProfilePersistence
    case childHome
    case parentalGate
    case fixtureSkillCheck
}

enum SupportLevel: String, Codable, CaseIterable, Sendable {
    case independent
    case hinted
    case modeled
    case simplified

    var next: Self {
        switch self {
        case .independent: .hinted
        case .hinted: .modeled
        case .modeled, .simplified: .simplified
        }
    }
}

enum InputModality: String, Codable, Sendable {
    case touch
    case voice
}

enum ResponseClassification: String, Codable, Sendable {
    case correct
    case incorrect
    case unscored
}

enum LearningSessionStatus: String, Codable, Sendable {
    case active
    case paused
    case completed
}

struct SkillCheckStep: Codable, Equatable, Identifiable, Sendable {
    let id: UUID
    let phoneme: String
    let prompt: String
    let choices: [String]
    let expectedChoice: String
    let familiar: Bool
}

struct AttemptEvidence: Codable, Equatable, Identifiable, Sendable {
    let id: UUID
    let stepID: UUID
    let presentedPhoneme: String
    let selectedResponse: String?
    let classification: ResponseClassification
    let supportLevel: SupportLevel
    let inputModality: InputModality
    let responseLatencyMilliseconds: Int
    let createdAt: Date
}

struct SkillCheckSession: Codable, Equatable, Identifiable, Sendable {
    let id: UUID
    let childID: UUID
    let curriculumVersion: String
    var status: LearningSessionStatus
    var currentStepIndex: Int
    var supportLevel: SupportLevel
    var attempts: [AttemptEvidence]
    var startedAt: Date
    var stepStartedAt: Date
    var completedAt: Date?
    let steps: [SkillCheckStep]

    var currentStep: SkillCheckStep? {
        guard steps.indices.contains(currentStepIndex) else { return nil }
        return steps[currentStepIndex]
    }

    var isComplete: Bool {
        status == .completed
    }
}

struct SkillCheckSummary: Equatable, Sendable {
    let completedSteps: Int
    let independentResponses: Int
    let supportedResponses: Int
    let incorrectAttempts: Int

    var observation: String {
        if supportedResponses > independentResponses {
            "Touch choices and small clues helped during this preview."
        } else {
            "Several sound choices were made independently in this preview."
        }
    }
}
