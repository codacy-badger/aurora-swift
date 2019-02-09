import Foundation

public class SimulatedConnector: Connectable {
    public let type: String

    public var onSync: ([Light]) -> Void = { _ in }
    public var onEvent: (Event) -> Void = { _ in }

    public init(type: String) {
        self.type = type
        print("SimulatedConnector: Init")
    }

    public func sync(lights: [Light]) {
        onSync(lights)
    }

    public func perform(lightUpdate: Light.Update) {
        print("SimulatedConnector: Performing light update")
        print(lightUpdate)
    }

    public func send(event: Event) {}

    public func connect(onSync: @escaping ([Light]) -> Void, onEvent: @escaping (Event) -> Void) {
        self.onSync = onSync
        self.onEvent = onEvent
    }
    deinit {
        print("SimulatedConnector: Deinit")
    }
}
