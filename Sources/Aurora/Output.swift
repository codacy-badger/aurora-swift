import Foundation

public struct Output {
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

    var audio: AudioOutputable?
}

public protocol AudioOutputable: AnyObject {
    func set(volume: Float)
    func play(track: String, volume: Float)
}
