import Foundation
import SwiftData

@Model
final class AppLearningSessionRecord {
    @Attribute(.unique) var id: UUID
    var childID: UUID
    var sessionData: Data
    var updatedAt: Date

    init(session: SkillCheckSession) {
        id = session.id
        childID = session.childID
        sessionData = Self.encode(session)
        updatedAt = .now
    }

    var domainModel: SkillCheckSession? {
        try? JSONDecoder().decode(SkillCheckSession.self, from: sessionData)
    }

    func update(from session: SkillCheckSession) {
        sessionData = Self.encode(session)
        updatedAt = .now
    }

    private static func encode(_ session: SkillCheckSession) -> Data {
        (try? JSONEncoder().encode(session)) ?? Data()
    }
}
