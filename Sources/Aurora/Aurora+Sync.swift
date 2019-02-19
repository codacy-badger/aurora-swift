import Foundation

extension Aurora {
    func sync(lights: [[String: Any]]) {
        sync(lights: lights.compactMap { Light(attributes: $0) })
    }

    func sync(lights: [Light]) {
        /// Sync lights
        if self.lights.sync(with: lights) {
            /// Notify delegate if necessary
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateLights() } }
        }
    }

    func sync(event: [String: Any]) {
        guard let name = event[Attribute.name.rawValue] as? String else { return }
        guard let type = event[Attribute.type.rawValue] as? String else { return }
        let payload = event[Attribute.payload.rawValue]
        let event = Event(name: name, type: type, payload: payload)
        DispatchQueue.main.async { self.delegates.forEach { $0.didReceive(event: event) } }
    }
}
