import Foundation

public class SimulatedAudioOutput: AudioOutputable {
    public init() {
        print("SimulatedAudioOutput: Init")
    }

    public func set(volume: Float) {}

    public func play(track: String, volume: Float) {}

    deinit {
        print("SimulatedAudioOutput: Deinit")
    }
}
