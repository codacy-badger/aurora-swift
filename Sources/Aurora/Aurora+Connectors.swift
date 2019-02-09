//
import Foundation

extension Aurora {
    public func attachConnectors() {
        update(connectors: connectors)
    }

    public func toggle(connector type: String) {
        if connectors.contains(type) {
            detach(connector: type)
        } else {
            attach(connector: type)
        }
    }

    public func attach(connector type: String) {
        connectors.insert(type)
        update(connectors: connectors)
    }

    public func detach(connector type: String) {
        connectors.remove(type)
        self.lights = lights.forcedUnreachable(forType: type)
        update(connectors: connectors)
        delegates.forEach { $0.didUpdateLights() }
    }

    internal func update(connectors: Set<String>) {
        /// Remove Connectors that are missing from the set.
        self.attachedConnectors.removeAll { !connectors.contains($0.type) }
        /// Add connectors that are in the set but not in an connectors array.
        connectors.forEach { type in
            if !self.attachedConnectors.contains(where: { $0.type == type }) {
                if let connector = constructor?.constructConnectorFor(type: type) {
                    /// Add connector to connectors array.
                    self.attachedConnectors.append(connector)
                    connector.connect(onSync: { self.sync(lights: $0) }, onEvent: { self.sync(event: $0) })
                    print("Aurora: Connected", type)
                } else {
                    print("Aurora: Unsupported Connector")
                }
            }
        }
        print("Aurora: Attached connectors:", self.attachedConnectors.map { $0.type })
        delegates.forEach { $0.didUpdateConnectors() }
    }
}
