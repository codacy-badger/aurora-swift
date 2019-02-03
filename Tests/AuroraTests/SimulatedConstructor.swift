import Aurora
import Foundation

class SimulatedConstructor: Constructable {
    func constructConnectorFor(type: String) -> Connectable? {
        switch type {
        case SimulatedConnector.type:
            return SimulatedConnector()

        default:
            return nil
        }
    }
}
