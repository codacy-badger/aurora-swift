import Aurora
import Foundation

public class SimulatedConnector: Connectable {
    public let type: String

    public var onSync: ([[String: Any]]) -> Void = { _ in }
    public var onEvent: ([String: Any]) -> Void = { _ in }

    public init(type: String) {
        self.type = type
        print("SimulatedConnector: Init")
    }

    public func sync(lights: [[String: Any]]) {
        onSync(lights)
    }

    public func perform(lightUpdate: [String: Any]) {
        print("SimulatedConnector: Performing light update")
        print(lightUpdate)
    }

    public func send(event: String, payload: Any?) {
        print("SimulatedConnector: Recieved an event:", event, payload ?? "No payload")
    }

    public func connect(onSync: @escaping ([[String: Any]]) -> Void, onEvent: @escaping ([String: Any]) -> Void) {
        self.onSync = onSync
        self.onEvent = onEvent
    }
    deinit {
        print("SimulatedConnector: Deinit")
    }
}
