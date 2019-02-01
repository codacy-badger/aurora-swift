import Foundation

extension Aurora {

    public func isActive(lightWithIdentifier identifier: UUID) -> Bool {
        return activeLightIdentifiers.contains(identifier)
    }

    /// Toggles active state for light with uuid.
    public func toggle(activeLightWithIdentifier identifier: UUID) {
        if activeLightIdentifiers.contains(identifier) {
            deactivate(lightsWithIdentifiers: [identifier])
        } else {
            activate(lightsWithIdentifiers: [identifier])
        }
    }

    public func activate(lightsWithIdentifiers identifiers: [UUID]) {
        activeLightIdentifiers.formUnion(identifiers)
        delegates.forEach { $0.didUpdateLights() }
    }

    public func deactivate(lightsWithIdentifiers identifiers: [UUID]) {
        activeLightIdentifiers.subtract(identifiers)
        delegates.forEach { $0.didUpdateLights() }
    }

    public var activeLights: [Light] {
        return lights.filter({ activeLightIdentifiers.contains($0.identifier) })
    }

    public func activeLights(forSceneWithIdentifier identifier: UUID) -> [Light] {
        guard let scene = scenes[identifier] else {
            return []
        }
        return lights.filter({ scene.lights.contains($0.identifier) })
    }

    public func resetLights() {
        self.lights = []
        delegates.forEach { $0.didUpdateLights() }
    }

    public func removeUnreachableLights() {
        self.lights = lights.reachable
        delegates.forEach { $0.didUpdateLights() }
    }
}
