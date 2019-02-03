import Foundation

public struct Input {
    public enum Mode: String, Equatable, Codable {
        case none, time, audio, video
    }

    public struct Settings: Codable, Equatable {
        public var mode: Mode
        /// Time between bursts
        public var interval: Float
        /// Burst duration
        public var transition: Float

        public init(mode: Mode, interval: Float, transition: Float) {
            self.mode = mode
            self.interval = interval
            self.transition = transition
        }
    }

    var time: TimeInputable?
    var audio: AudioInputable?
    var video: VideoInputable?
}

public protocol TimeInputable: AnyObject {
    func start(onLoop: @escaping (UUID) -> Void)
    func add(loop: UUID, duration: Float)
    func remove(loop: UUID)
}

public protocol AudioInputable: AnyObject {
    var processor: AudioProcessor { get set }

    func start(onLevel: @escaping (Float) -> Void)
    func stop()
}

public protocol VideoInputable: AnyObject {
    var processor: VideoProcessor { get set }

    func start(index: Int, onColor: @escaping (_ hue: Float, _ brightness: Float, _ saturation: Float) -> Void)
    func stop()
}
