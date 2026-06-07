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
}
