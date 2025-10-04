import Foundation
import AudioToolbox

final class SoundFeedback {
    static let shared = SoundFeedback()
    private init() {}

    // Rate limiting so we don't overwhelm the user while dragging
    private var lastTickTime: CFTimeInterval = 0
    private let minTickInterval: CFTimeInterval = 0.05 // 50ms between ticks

    /// Plays a subtle tick sound. Safe to call frequently; internally rate-limited.
    func playTick() {
        let now = CFAbsoluteTimeGetCurrent()
        if now - lastTickTime < minTickInterval { return }
        lastTickTime = now
        // 1104 is a subtle system 'Tock' commonly used for keyboard clicks
        AudioServicesPlaySystemSound(1104)
    }
}
