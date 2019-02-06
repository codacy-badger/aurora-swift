import Foundation

extension Aurora {
    /// Stable

    /// Simplex-only property get an active scene. This will return `nil` in a multiplex mode.
    public var scene: Scene? {
        return mode == .simplex ? activeScenes.first : nil
    }

    ///
    public var activeScenes: [Scene] {
        return scenes.filter { activeSceneIdentifiers.contains($0.identifier) }
    }

    public var inactiveScenes: [Scene] {
        return scenes.filter { !activeSceneIdentifiers.contains($0.identifier) }
    }

    public func isActive(sceneWithIdentifier identifier: UUID) -> Bool {
        return activeSceneIdentifiers.contains(identifier)
    }

    public func toggle(sceneWithIdentifier identifier: UUID) {
        guard scenes.contains(where: { $0.identifier == identifier }) else {
            return
        }

        switch mode {
        case .simplex:
            if isActive(sceneWithIdentifier: identifier) {
                activeSceneIdentifiers = []
            } else {
                activeSceneIdentifiers = [identifier]
            }

        case .multiplex:
            if isActive(sceneWithIdentifier: identifier) {
                activeSceneIdentifiers.remove(identifier)
            } else {
                activeSceneIdentifiers.insert(identifier)
            }
        }

        refreshInputs()
        refreshOutputs()

        delegates.forEach { $0.didUpdateScenes() }
    }

    public func deactivateScenes() {
        activeSceneIdentifiers = []
        refreshInputs()
        refreshOutputs()
        delegates.forEach { $0.didUpdateScenes() }
    }

    public func add(scenes: [Scene]) {
        self.scenes += scenes
        delegates.forEach { $0.didUpdateScenes() }
    }

    public func remove(scene: Scene) {
        guard let index = scenes.index(of: scene) else {
            return
        }
        scenes.remove(at: index)
        delegates.forEach { $0.didUpdateScenes() }
    }

    public func reset(scenes: [Scene]) {
        activeSceneIdentifiers = []
        self.scenes = scenes
        delegates.forEach { $0.didUpdateScenes() }
    }
}
