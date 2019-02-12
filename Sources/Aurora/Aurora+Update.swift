import Foundation

extension Aurora {
    internal func update(lights: [Light], with transformer: @escaping LightsTransformer) {
        if transformatorLock {
            print("Blocked with transformator lock")
            return
        }
        transformatorLock = true

        DispatchQueue.global(qos: .userInitiated).async {
            /// Generate transformer output
            let result = transformer(lights)
            DispatchQueue.main.async {
                self.transformatorLock = false
                var lights = self.lights
                let updatedLights = result.map { $0.updatedLight }
                updatedLights.forEach {
                    lights[$0.identifier] = $0
                }
                self.lights = lights
                self.send(lightUpdates: result.map { $0.update })
                self.delegates.forEach { $0.didUpdateColorsForLightsWith(identifiers: updatedLights.map { $0.identifier }) }
            }
        }
    }

    public func send(lightUpdates: [[String: Any]]) {
        lightUpdates.forEach { update in
            guard let updateType = update[Attribute.type.rawValue] as? String else { return }
            attachedConnectors.first { $0.type == updateType }?.perform(lightUpdate: update)
        }
    }

    public func send(event: Event) {
        if let connector = attachedConnectors.first(where: { $0.type == event.type }) {
            connector.send(event: event.name, payload: event.payload)
        }
    }
}
