import Foundation

extension Aurora {
    /// Adds delegate to an array if delegate is new.
    /// Will update delegate with update events for connectors, lights, preset and presets.
    public func add(delegate: AuroraDelegate) {
        if !delegates.contains(where: { $0 === delegate }) {
            delegates.append(delegate)
            delegate.didUpdateConnectors()
            delegate.didUpdateLights()
            delegate.didUpdateScenes()
            print("Delegates", delegates.count)
        }
    }

    /// Removes delegate from the array.
    /// Delegate is responsible for deleting itself with this method call.
    public func remove(delegate: AuroraDelegate) {
        if let index = delegates.firstIndex(where: { $0 === delegate }) {
            delegates.remove(at: index)
            print("Delegates", delegates.count)
        }
    }
}
