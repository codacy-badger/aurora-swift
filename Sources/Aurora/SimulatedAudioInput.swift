import Foundation

public class SimulatedAudioInput: AudioInputable {
    public var processor = AudioProcessor()

    public init() {
        print("SimulatedAudioInput: Init")
    }

    public func start(onLevel: @escaping (Float) -> Void) {}

    public func stop() {}

    deinit {
        print("SimulatedAudioInput: Deinit")
    }
}
