import Foundation

public protocol AudioOutputable: AnyObject {
    func set(volume: Float)
    func play(track: String, volume: Float)
}

public struct Output {
    public struct Generator {
        let audio: () -> AudioOutputable?

        public init(audio: @escaping () -> AudioOutputable? = { nil }) {
            self.audio = audio
        }
    }

    var audio: AudioOutputable?
}
