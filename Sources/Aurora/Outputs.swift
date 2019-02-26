import Foundation

public struct Outputs {
    public enum Mode: String, Equatable, Codable {
        case none, audio
    }

    public struct Settings: Codable, Equatable {
        public var mode: Mode
        public var track: String?

        public init(mode: Mode = .none, track: String? = nil) {
            self.mode = mode
            self.track = track
        }
    }

    public struct Generator {
        let audio: () -> AudioOutputable?

        public init(audio: @escaping () -> AudioOutputable? = { nil }) {
            self.audio = audio
        }
    }

    var audio: AudioOutputable?
}

public protocol AudioOutputable: AnyObject {
    func set(volume: Float)
    func play(track: String, volume: Float)
}
