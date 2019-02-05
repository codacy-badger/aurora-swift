import Foundation

public class SimulatedVideoInput: VideoInputable {
    public var processor = VideoProcessor()

    public init() {
        print("SimulatedVideoInput: Init")
    }

    public func start(index: Int, onColor: @escaping (Float, Float, Float) -> Void) {}

    public func stop() {}

    deinit {
        print("SimulatedVideoInput: Deinit")
    }
}
