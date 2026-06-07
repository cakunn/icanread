import XCTest
@testable import ICanRead

final class DomainTests: XCTestCase {
    func testSetupRequiresNameInterestAndRequiredConsent() {
        var draft = SetupDraft.empty
        XCTAssertFalse(draft.canComplete)

        draft.firstName = "Sam"
        draft.interests = [.dragons]
        draft.consent.microphoneProcessing = true
        draft.consent.cloudAIProcessing = true

        XCTAssertTrue(draft.canComplete)
    }

    func testAudioRetentionIsOptional() {
        var consent = ConsentRecord.empty
        consent.microphoneProcessing = true
        consent.cloudAIProcessing = true
        consent.retainSelectedAudio = false

        XCTAssertTrue(consent.requiredConsentsAccepted)
    }

    func testConfigurationDefaultsToFixtureMode() {
        XCTAssertEqual(
            AppConfiguration.current(environment: [:]),
            AppConfiguration(dataMode: .fixture)
        )
    }

    func testConfigurationUsesRemoteURLWhenPresent() {
        let configuration = AppConfiguration.current(
            environment: ["ICANREAD_API_BASE_URL": "https://example.test"]
        )
        XCTAssertEqual(
            configuration,
            AppConfiguration(dataMode: .remote(baseURL: URL(string: "https://example.test")!))
        )
    }
}
