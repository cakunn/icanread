import SwiftData
import SwiftUI

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var records: [AppProfileRecord]
    @State private var route: AppRoute = .loading

    var body: some View {
        Group {
            switch route {
            case .loading:
                ProgressView("Getting things ready...")
                    .task { loadRoute() }
            case .parentSetup(let draft):
                ParentSetupFlow(
                    initialDraft: draft,
                    onComplete: saveAndEnterChildMode
                )
            case .childHome(let profile):
                ChildHomeView(
                    profile: profile,
                    onStartAdventure: { route = .skillCheck(profile) },
                    onEnterParentMode: { route = .parentOverview(profile) }
                )
            case .skillCheck(let profile):
                SkillCheckView(profile: profile) {
                    route = .childHome(profile)
                }
            case .parentOverview(let profile):
                ParentOverviewView(
                    profile: profile,
                    onEditSetup: { route = .parentSetup(profile.setupDraft) },
                    onReturnToChild: { route = .childHome(profile) }
                )
            }
        }
        .tint(DesignTokens.actionPrimary)
    }

    private func loadRoute() {
        guard let record = records.first else {
            route = .parentSetup(.empty)
            return
        }

        let profile = record.domainModel
        route = profile.setupComplete ? .childHome(profile) : .parentSetup(profile.setupDraft)
    }

    private func saveAndEnterChildMode(_ draft: SetupDraft) {
        let profile = ChildProfile(
            id: records.first?.id ?? UUID(),
            firstName: draft.firstName.trimmingCharacters(in: .whitespacesAndNewlines),
            age: draft.age,
            interests: draft.interests.sorted { $0.rawValue < $1.rawValue },
            accessibilityPreferences: draft.accessibilityPreferences,
            consent: draft.consent,
            setupComplete: true
        )

        if let record = records.first {
            record.update(from: profile)
        } else {
            modelContext.insert(AppProfileRecord(profile: profile))
        }

        try? modelContext.save()
        route = .childHome(profile)
    }
}

enum AppRoute {
    case loading
    case parentSetup(SetupDraft)
    case childHome(ChildProfile)
    case skillCheck(ChildProfile)
    case parentOverview(ChildProfile)
}
