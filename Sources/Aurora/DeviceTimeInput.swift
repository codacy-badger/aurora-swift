import Foundation

public class DeviceTimeInput: TimeInputable {
    public var loopVariations: [UUID: UUID] = [:]
    private var onLoop: (UUID) -> Void = { _ in }

    public func start(onLoop: @escaping (UUID) -> Void) {
        self.onLoop = onLoop
    }

    public func add(loop: UUID, duration: Float) {
        let variation = UUID()
        loopVariations[loop] = variation
        self.loop(variation: variation, for: loop, duration: duration)
    }

    public func remove(loop: UUID) {
        loopVariations[loop] = nil
    }

    public init() {
        print("DeviceTimeInput: Init")
    }

    deinit {
        print("DeviceTimeInput: Deinit")
    }

    private func loop(variation: UUID, for loop: UUID, duration: Float) {
        if loopVariations[loop] != variation {
            print("Loop Cycle Invalid : Loop is stopping")
            return
        }

        print("Time Loop", loop)
        onLoop(loop)

        DispatchQueue.main.asyncAfter(deadline: .now() + Double(duration)) { [weak self] in
            self?.loop(variation: variation, for: loop, duration: duration)
        }
    }
}
