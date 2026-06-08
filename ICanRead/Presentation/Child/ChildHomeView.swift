import SwiftUI

struct ChildHomeView: View {
    let profile: ChildProfile
    let onStartAdventure: () -> Void
    let onEnterParentMode: () -> Void
    @State private var showingParentGate = false

    private let destinations: [(String, String, String)] = [
        ("Stories", "books.vertical.fill", "Curated stories are not available yet."),
        ("Toy Shelf", "shippingbox.fill", "Your toy shelf is ready for future rewards."),
        ("My Creations", "paintpalette.fill", "Creations will appear after learning activities.")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                DesignTokens.surfacePrimary.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Hi, \(profile.firstName)!")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundStyle(DesignTokens.textPrimary)
                        Text("What would you like to explore?")
                            .font(.title2)
                        Button(action: onStartAdventure) {
                            HStack(spacing: 18) {
                                Image(systemName: "map.fill")
                                    .font(.system(size: 44))
                                    .foregroundStyle(DesignTokens.actionPrimary)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Adventure")
                                        .font(.title.bold())
                                    Text("Try a short sound adventure")
                                        .font(.headline)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.title2.bold())
                            }
                            .foregroundStyle(DesignTokens.textPrimary)
                            .padding(22)
                            .frame(maxWidth: .infinity, minHeight: 126)
                            .background(
                                LinearGradient(
                                    colors: [.white, DesignTokens.success.opacity(0.12)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                in: RoundedRectangle(cornerRadius: 26)
                            )
                            .shadow(color: DesignTokens.shadow, radius: 10, y: 5)
                        }
                        .buttonStyle(.plain)
                        .accessibilityHint("Starts the unverified fixture sound preview")
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 155), spacing: 16)], spacing: 16) {
                            ForEach(destinations, id: \.0) { item in
                                NavigationLink {
                                    CapabilityPreviewView(
                                        title: item.0,
                                        symbol: item.1,
                                        message: item.2
                                    )
                                } label: {
                                    VStack(spacing: 14) {
                                        Image(systemName: item.1)
                                            .font(.system(size: 42))
                                        Text(item.0)
                                            .font(.title3.bold())
                                    }
                                    .foregroundStyle(DesignTokens.textPrimary)
                                    .frame(maxWidth: .infinity, minHeight: 150)
                                    .background(.white, in: RoundedRectangle(cornerRadius: 24))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        Label("Preview content has not received literacy or voice review.", systemImage: "exclamationmark.triangle.fill")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(DesignTokens.textPrimary)
                            .padding(14)
                            .background(DesignTokens.attention.opacity(0.18), in: RoundedRectangle(cornerRadius: 14))
                        Button {
                            showingParentGate = true
                        } label: {
                            Label("Parent area", systemImage: "lock.fill")
                                .frame(minHeight: 52)
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding(24)
                    .frame(maxWidth: 760)
                }
            }
        }
        .sheet(isPresented: $showingParentGate) {
            ParentGateView {
                showingParentGate = false
                onEnterParentMode()
            }
        }
    }
}

private struct CapabilityPreviewView: View {
    let title: String
    let symbol: String
    let message: String

    var body: some View {
        ZStack {
            DesignTokens.surfacePrimary.ignoresSafeArea()
            VStack(spacing: 24) {
                Image(systemName: symbol)
                    .font(.system(size: 72))
                    .foregroundStyle(DesignTokens.actionPrimary)
                Text(title).font(.largeTitle.bold())
                Text(message)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(32)
        }
    }
}

private struct ParentGateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var answer = ""
    let onSuccess: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "person.badge.key.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(DesignTokens.actionPrimary)
                Text("Parent check")
                    .font(.largeTitle.bold())
                Text("What is 7 + 6?")
                    .font(.title2)
                TextField("Answer", text: $answer)
                    .keyboardType(.numberPad)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(DesignTokens.surfacePrimary, in: RoundedRectangle(cornerRadius: 16))
                    .frame(maxWidth: 220)
                Button("Continue") {
                    if answer == "13" {
                        onSuccess()
                    }
                }
                .buttonStyle(ChildPrimaryButtonStyle())
                .disabled(answer != "13")
            }
            .padding(28)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
