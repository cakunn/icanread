import AVFoundation
import Foundation

struct PhonemeAudioDescriptor: Equatable, Sendable {
    let phoneme: String
    let assetVersion: String
    let reviewStatus: ReviewStatus

    enum ReviewStatus: String, Sendable {
        case unreviewedPreview
        case expertReviewed
    }
}

@MainActor
final class PreviewPhonemeAudioPlayer {
    private let synthesizer = AVSpeechSynthesizer()

    static let descriptors = ["/m/", "/a/", "/s/", "/t/"].map {
        PhonemeAudioDescriptor(
            phoneme: $0,
            assetVersion: "synthetic-preview-1",
            reviewStatus: .unreviewedPreview
        )
    }

    func play(_ phoneme: String, slower: Bool) {
        synthesizer.stopSpeaking(at: .immediate)
        let spokenForm = switch phoneme {
        case "/m/": "mmmm"
        case "/a/": "aaa"
        case "/s/": "ssss"
        case "/t/": "t"
        default: phoneme.replacingOccurrences(of: "/", with: "")
        }
        let utterance = AVSpeechUtterance(string: spokenForm)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = slower ? 0.34 : 0.42
        utterance.pitchMultiplier = 1.05
        synthesizer.speak(utterance)
    }
}
