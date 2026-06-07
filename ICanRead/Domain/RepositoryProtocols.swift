import Foundation

protocol AuthRepository: Sendable {
    func signInWithApple(identityToken: Data) async throws -> ParentSession
    func signInWithDebugFixture() async throws -> ParentSession
}

protocol ChildProfileRepository: Sendable {
    func loadProfile() async throws -> ChildProfile?
    func saveProfile(_ profile: ChildProfile) async throws
}

protocol ConsentRepository: Sendable {
    func saveConsent(_ consent: ConsentRecord, childID: UUID) async throws
}

struct AppConfiguration: Equatable, Sendable {
    enum DataMode: Equatable, Sendable {
        case fixture
        case remote(baseURL: URL)
    }

    let dataMode: DataMode

    static func current(environment: [String: String] = ProcessInfo.processInfo.environment) -> Self {
        guard
            let rawURL = environment["ICANREAD_API_BASE_URL"],
            let url = URL(string: rawURL)
        else {
            return AppConfiguration(dataMode: .fixture)
        }
        return AppConfiguration(dataMode: .remote(baseURL: url))
    }
}
