import AuthenticationServices
import SwiftUI

struct ParentSetupFlow: View {
    @State private var draft: SetupDraft
    @State private var step: Step = .welcome
    let onComplete: (SetupDraft) -> Void

    init(initialDraft: SetupDraft, onComplete: @escaping (SetupDraft) -> Void) {
        _draft = State(initialValue: initialDraft)
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            ZStack {
                DesignTokens.surfacePrimary.ignoresSafeArea()
                VStack(spacing: 24) {
                    ProgressView(value: step.progress)
                        .tint(DesignTokens.actionPrimary)
                        .accessibilityLabel("Setup progress")
                    stepContent
                    Spacer(minLength: 8)
                    navigationControls
                }
                .padding(24)
                .frame(maxWidth: 720)
            }
            .navigationTitle(step.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    @ViewBuilder
    private var stepContent: some View {
        switch step {
        case .welcome:
            welcome
        case .consent:
            consent
        case .profile:
            profile
        case .interests:
            interests
        case .accessibility:
            accessibility
        case .review:
            review
        }
    }

    private var welcome: some View {
        VStack(spacing: 24) {
            Image(systemName: "book.pages.fill")
                .font(.system(size: 76))
                .foregroundStyle(DesignTokens.actionPrimary)
            Text("Reading practice shaped around your child")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            Text("A parent sets up the account. Your child chooses themes and activities within a structured phonics path.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            SignInWithAppleButton(.continue) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { _ in
                step = .consent
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 54)
            .clipShape(RoundedRectangle(cornerRadius: 14))

#if DEBUG
            Button("Continue in local demo") {
                step = .consent
            }
            .font(.headline)
            .accessibilityHint("Uses local fixture data and does not create an account")
#endif
        }
    }

    private var consent: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your child stays in control")
                .font(.largeTitle.bold())
            Text("Audio is captured only during a visible listening turn. In the full service, short utterances will be securely processed in the cloud.")
                .font(.title3)
            ConsentToggle(
                title: "Allow microphone processing",
                detail: "Required for spoken reading and sound practice.",
                isOn: $draft.consent.microphoneProcessing
            )
            ConsentToggle(
                title: "Allow secure cloud AI processing",
                detail: "Required for speech recognition and guided conversation.",
                isOn: $draft.consent.cloudAIProcessing
            )
            ConsentToggle(
                title: "Keep selected recordings",
                detail: "Optional. Off by default and removable by the parent.",
                isOn: $draft.consent.retainSelectedAudio
            )
        }
    }

    private var profile: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("Who will be reading?")
                .font(.largeTitle.bold())
            TextField("First name", text: $draft.firstName)
                .textContentType(.givenName)
                .font(.title2)
                .padding()
                .background(.white, in: RoundedRectangle(cornerRadius: 16))
            Stepper("Age: \(draft.age)", value: $draft.age, in: 4...10)
                .font(.title3)
            Text("Use only a first name. Stories remain fictional unless a parent approves otherwise.")
                .foregroundStyle(.secondary)
        }
    }

    private var interests: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What sparks curiosity?")
                .font(.largeTitle.bold())
            Text("Choose at least one. These shape themes, not the learning sequence.")
                .font(.title3)
                .foregroundStyle(.secondary)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 14)], spacing: 14) {
                ForEach(Interest.allCases) { interest in
                    ChoiceCard(
                        title: interest.rawValue.capitalized,
                        symbol: interest.symbol,
                        selected: draft.interests.contains(interest)
                    ) {
                        if draft.interests.contains(interest) {
                            draft.interests.remove(interest)
                        } else {
                            draft.interests.insert(interest)
                        }
                    }
                }
            }
        }
    }

    private var accessibility: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Make the experience comfortable")
                .font(.largeTitle.bold())
            Toggle("Use a slower teacher voice", isOn: $draft.accessibilityPreferences.slowerTeacherVoice)
            Toggle("Reduce motion", isOn: $draft.accessibilityPreferences.reducedMotion)
            Toggle("Show captions with spoken instructions", isOn: $draft.accessibilityPreferences.captionsEnabled)
            Text("These can be changed later in parent settings.")
                .foregroundStyle(.secondary)
        }
        .font(.title3)
    }

    private var review: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Ready for \(draft.firstName)?")
                .font(.largeTitle.bold())
            ReviewRow(label: "Age", value: "\(draft.age)")
            ReviewRow(
                label: "Interests",
                value: draft.interests.map(\.rawValue).sorted().joined(separator: ", ")
            )
            ReviewRow(
                label: "Recordings",
                value: draft.consent.retainSelectedAudio ? "Selected recordings may be kept" : "Not retained"
            )
            Label("Learning activities are not included in this foundation build yet.", systemImage: "hammer.fill")
                .padding()
                .background(DesignTokens.focusSound.opacity(0.14), in: RoundedRectangle(cornerRadius: 14))
        }
    }

    private var navigationControls: some View {
        HStack(spacing: 16) {
            if step != .welcome {
                Button("Back") { step = step.previous }
                    .frame(minWidth: 80, minHeight: 52)
            }
            if step != .welcome {
                Button(step == .review ? "Enter child mode" : "Continue") {
                    if step == .review {
                        draft.consent.acceptedAt = .now
                        onComplete(draft)
                    } else {
                        step = step.next
                    }
                }
                .buttonStyle(ChildPrimaryButtonStyle())
                .disabled(!canContinue)
            }
        }
    }

    private var canContinue: Bool {
        switch step {
        case .welcome: true
        case .consent: draft.consent.requiredConsentsAccepted
        case .profile: !draft.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        case .interests: !draft.interests.isEmpty
        case .accessibility: true
        case .review: draft.canComplete
        }
    }

    enum Step: Int, CaseIterable {
        case welcome
        case consent
        case profile
        case interests
        case accessibility
        case review

        var title: String {
            switch self {
            case .welcome: "Parent setup"
            case .consent: "Privacy"
            case .profile: "Child profile"
            case .interests: "Interests"
            case .accessibility: "Comfort"
            case .review: "Review"
            }
        }

        var progress: Double {
            Double(rawValue + 1) / Double(Self.allCases.count)
        }

        var next: Self {
            Self(rawValue: min(rawValue + 1, Self.allCases.count - 1)) ?? self
        }

        var previous: Self {
            Self(rawValue: max(rawValue - 1, 0)) ?? self
        }
    }
}

private struct ConsentToggle: View {
    let title: String
    let detail: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct ReviewRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption.weight(.semibold)).foregroundStyle(.secondary)
            Text(value).font(.title3)
        }
    }
}
