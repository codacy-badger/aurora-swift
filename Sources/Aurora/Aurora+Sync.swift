import Foundation

extension Aurora {
    public func sync(lights: [[String: Any]]) {
        print("Aurora: Syncing lights from attributes")
        print(lights)
        sync(lights: lights.compactMap { Light(attributes: $0) })
    }

    public func sync(lights: [Light]) {
        print("Aurora: Syncing lights")
        print(lights)
        /// Sync lights
        if self.lights.sync(with: lights) {
            /// Notify delegate if necessary
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateLights() } }
        }
    }

    public func sync(event: [String: Any]) {
        /// Check if event has a type attribute and is coming from active connector.
        guard let type = event[Attribute.type.rawValue] as? String, connectors.contains(type) else { return }
        /// Check if event has a name attribute.
        guard let name = event[Attribute.name.rawValue] as? String else { return }

        let payload = event[Attribute.payload.rawValue]
        let event = Event(name: name, type: type, payload: payload)
        DispatchQueue.main.async { self.delegates.forEach { $0.didReceive(event: event) } }
    }
}
