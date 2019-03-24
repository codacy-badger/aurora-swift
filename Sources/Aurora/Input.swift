import Foundation

public struct Input {
    public struct Generator {
        let time: () -> TimeInputable?
        let audio: () -> AudioInputable?
        let video: () -> VideoInputable?

        public init(time: @escaping () -> TimeInputable? = { nil }, audio: @escaping () -> AudioInputable? = { nil }, video: @escaping () -> VideoInputable? = { nil }) {
            self.time = time
            self.audio = audio
            self.video = video
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
