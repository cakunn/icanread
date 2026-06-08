import SwiftData
import SwiftUI

struct ParentOverviewView: View {
    let profile: ChildProfile
    let onEditSetup: () -> Void
    let onReturnToChild: () -> Void

    @Query private var records: [AppLearningSessionRecord]

    private var latestSession: SkillCheckSession? {
        records
            .compactMap(\.domainModel)
            .filter { $0.childID == profile.id }
            .sorted { $0.startedAt > $1.startedAt }
            .first
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("\(profile.firstName)'s reading")
                        .font(.largeTitle.bold())
                    previewNotice
                    if let latestSession {
                        evidenceCard(latestSession)
                    } else {
                        ContentUnavailableView(
                            "No sound adventure yet",
                            systemImage: "waveform",
                            description: Text("Complete the fixture preview to see attempt evidence.")
                        )
                    }
                    Button("Edit parent setup", action: onEditSetup)
                        .buttonStyle(.bordered)
                    Button("Return to child mode", action: onReturnToChild)
                        .buttonStyle(ChildPrimaryButtonStyle())
                }
                .padding(24)
                .frame(maxWidth: 720)
                .frame(maxWidth: .infinity)
            }
            .background(DesignTokens.surfacePrimary)
        }
    }

    private var previewNotice: some View {
        Label(
            "This evidence comes from unreviewed fixture content and cannot establish placement or mastery.",
            systemImage: "exclamationmark.triangle.fill"
        )
        .font(.headline)
        .padding()
        .background(DesignTokens.attention.opacity(0.18), in: RoundedRectangle(cornerRadius: 16))
    }

    private func evidenceCard(_ session: SkillCheckSession) -> some View {
        let summary = SkillCheckEngine.summary(for: session)
        return VStack(alignment: .leading, spacing: 18) {
            Text(session.isComplete ? "Recent preview" : "Preview in progress")
                .font(.title.bold())
            Text(summary.observation)
                .font(.title3)
            Divider()
            evidenceRow("Sound turns completed", value: "\(summary.completedSteps)")
            evidenceRow("Independent matches", value: "\(summary.independentResponses)")
            evidenceRow("Matches after support", value: "\(summary.supportedResponses)")
            evidenceRow("Attempts that led to a clue", value: "\(summary.incorrectAttempts)")
            Text("Response timing is stored as private diagnostic evidence and is not shown as a child score.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(22)
        .background(.white, in: RoundedRectangle(cornerRadius: 24))
        .shadow(color: DesignTokens.shadow, radius: 10, y: 5)
    }

    private func evidenceRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value).fontWeight(.bold)
        }
        .font(.headline)
    }
}
