import Foundation

public struct Input {
    public enum Mode: String, Equatable, Codable, CaseIterable {
        case none, time, audio, video
    }

    public struct Settings: Codable, Equatable {
        public var mode: Mode
        /// Time between bursts
        public var interval: Float
        /// Burst duration
        public var transition: Float

        public init(mode: Mode = .none, interval: Float = 1.0, transition: Float = 0.0) {
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
    var loopVariations: [UUID: UUID] { get }

    func start(onLoop: @escaping (UUID) -> Void)
    func add(loop: UUID, duration: Float)
    func remove(loop: UUID)
}

public protocol AudioInputable: AnyObject {
    func start(onLevel: @escaping (Float) -> Void)
}

public protocol VideoInputable: AnyObject {
    func start(index: Int, onColor: @escaping (_ hue: Float, _ brightness: Float, _ saturation: Float) -> Void)
}
