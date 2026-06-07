import Foundation

struct FixtureAuthRepository: AuthRepository {
    func signInWithApple(identityToken: Data) async throws -> ParentSession {
        ParentSession(parentID: UUID(), authenticationMethod: .signInWithApple)
    }

    func signInWithDebugFixture() async throws -> ParentSession {
        ParentSession(parentID: UUID(), authenticationMethod: .debugFixture)
    }
}
