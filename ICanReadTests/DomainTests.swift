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

    func testFixtureSessionUsesDeterministicStepOrder() {
        let session = SkillCheckFixture.makeSession(childID: UUID())
        XCTAssertEqual(session.steps.map(\.phoneme), ["/m/", "/a/", "/s/", "/t/"])
        XCTAssertTrue(session.steps[0].familiar)
    }

    func testCorrectTouchAttemptAdvancesAndStoresEvidence() {
        let start = Date(timeIntervalSince1970: 100)
        let session = SkillCheckFixture.makeSession(childID: UUID(), now: start)
        let updated = SkillCheckEngine.record(
            selection: "m",
            in: session,
            now: start.addingTimeInterval(1.2)
        )

        XCTAssertEqual(updated.currentStepIndex, 1)
        XCTAssertEqual(updated.attempts.first?.classification, .correct)
        XCTAssertEqual(updated.attempts.first?.supportLevel, .independent)
        XCTAssertEqual(updated.attempts.first?.responseLatencyMilliseconds, 1_200)
    }

    func testIncorrectAttemptEscalatesSupportWithoutAdvancing() {
        let session = SkillCheckFixture.makeSession(childID: UUID())
        let updated = SkillCheckEngine.record(selection: "s", in: session)

        XCTAssertEqual(updated.currentStepIndex, 0)
        XCTAssertEqual(updated.supportLevel, .hinted)
        XCTAssertEqual(updated.attempts.first?.classification, .incorrect)
    }

    func testUncertainAttemptIsUnscored() {
        let session = SkillCheckFixture.makeSession(childID: UUID())
        let updated = SkillCheckEngine.record(selection: nil, in: session)

        XCTAssertEqual(updated.currentStepIndex, 0)
        XCTAssertEqual(updated.supportLevel, .independent)
        XCTAssertEqual(updated.attempts.first?.classification, .unscored)
    }

    func testPauseAndResumePreserveProgress() {
        var session = SkillCheckFixture.makeSession(childID: UUID())
        session = SkillCheckEngine.record(selection: "m", in: session)
        let paused = SkillCheckEngine.pause(session)
        let resumed = SkillCheckEngine.resume(paused)

        XCTAssertEqual(paused.status, .paused)
        XCTAssertEqual(resumed.status, .active)
        XCTAssertEqual(resumed.currentStepIndex, 1)
        XCTAssertEqual(resumed.attempts.count, 1)
    }

    func testCompletionSummaryDoesNotInferMastery() {
        var session = SkillCheckFixture.makeSession(childID: UUID())
        for answer in ["m", "a", "s", "t"] {
            session = SkillCheckEngine.record(selection: answer, in: session)
        }
        let summary = SkillCheckEngine.summary(for: session)

        XCTAssertTrue(session.isComplete)
        XCTAssertEqual(summary.completedSteps, 4)
        XCTAssertEqual(summary.independentResponses, 4)
    }
}
