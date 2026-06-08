import SwiftUI

enum DesignTokens {
    static let surfacePrimary = Color(red: 0.98, green: 0.96, blue: 0.90)
    static let surfaceRaised = Color.white
    static let textPrimary = Color(red: 0.10, green: 0.15, blue: 0.20)
    static let actionPrimary = Color(red: 0.16, green: 0.45, blue: 0.42)
    static let listening = Color(red: 0.16, green: 0.43, blue: 0.75)
    static let focusSound = Color(red: 0.92, green: 0.48, blue: 0.16)
    static let success = Color(red: 0.28, green: 0.60, blue: 0.34)
    static let attention = Color(red: 0.88, green: 0.55, blue: 0.18)
    static let leaf = Color(red: 0.22, green: 0.38, blue: 0.24)
    static let shadow = Color.black.opacity(0.12)
}

struct ChildPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 56)
            .padding(.horizontal, 20)
            .background(DesignTokens.actionPrimary.opacity(configuration.isPressed ? 0.75 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

struct ChoiceCard: View {
    let title: String
    let symbol: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: symbol)
                    .font(.system(size: 30, weight: .semibold))
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(DesignTokens.textPrimary)
            .frame(maxWidth: .infinity, minHeight: 96)
            .padding(12)
            .background(selected ? DesignTokens.focusSound.opacity(0.22) : DesignTokens.surfaceRaised)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(selected ? DesignTokens.focusSound : .clear, lineWidth: 3)
            }
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}
