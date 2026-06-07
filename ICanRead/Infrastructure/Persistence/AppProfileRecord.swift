import Foundation
import SwiftData

@Model
final class AppProfileRecord {
    @Attribute(.unique) var id: UUID
    var firstName: String
    var age: Int
    var interestsData: Data
    var accessibilityData: Data
    var consentData: Data
    var setupComplete: Bool
    var updatedAt: Date

    init(profile: ChildProfile) {
        id = profile.id
        firstName = profile.firstName
        age = profile.age
        interestsData = Self.encode(profile.interests)
        accessibilityData = Self.encode(profile.accessibilityPreferences)
        consentData = Self.encode(profile.consent)
        setupComplete = profile.setupComplete
        updatedAt = .now
    }

    var domainModel: ChildProfile {
        ChildProfile(
            id: id,
            firstName: firstName,
            age: age,
            interests: Self.decode([Interest].self, from: interestsData) ?? [],
            accessibilityPreferences: Self.decode(
                AccessibilityPreferences.self,
                from: accessibilityData
            ) ?? .default,
            consent: Self.decode(ConsentRecord.self, from: consentData) ?? .empty,
            setupComplete: setupComplete
        )
    }

    func update(from profile: ChildProfile) {
        firstName = profile.firstName
        age = profile.age
        interestsData = Self.encode(profile.interests)
        accessibilityData = Self.encode(profile.accessibilityPreferences)
        consentData = Self.encode(profile.consent)
        setupComplete = profile.setupComplete
        updatedAt = .now
    }

    private static func encode<T: Encodable>(_ value: T) -> Data {
        (try? JSONEncoder().encode(value)) ?? Data()
    }

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        try? JSONDecoder().decode(type, from: data)
    }
}
