import Aurora
import Foundation

class SimulatedConnector: Connectable {
    static let type: String = "simulated"

    func perform(lightUpdate: Light.Update) {
    }

    func send(event: Event) {
    }

    func connect(onSync: @escaping ([Light]) -> Void, onEvent: @escaping (Event) -> Void) {
    }
}
