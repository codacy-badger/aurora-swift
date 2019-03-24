import Foundation

extension Aurora {
    public func toggle(lightWithIdentifier lightIdentifier: UUID, forSceneWithIdentifier sceneIdentifier: UUID) {
        guard let scene = scenes[sceneIdentifier] else {
            return
        }
        if scene.lights.contains(lightIdentifier) {
            remove(lightIdentifiers: [lightIdentifier], fromSceneWithIdentifier: sceneIdentifier)
        } else {
            add(lightIdentifiers: [lightIdentifier], toSceneWithIdentifier: sceneIdentifier)
        }
    }

    public func add(lightIdentifiers identifiers: [UUID], toSceneWithIdentifier sceneIdentifier: UUID) {
        guard scenes.contains(where: { $0.identifier == sceneIdentifier }) else {
            return
        }
        scenes[sceneIdentifier]?.lights.formUnion(identifiers)
        print(activeLightIdentifiers)
        DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateLightsForSceneWith(identifier: sceneIdentifier) } }
    }

    public func remove(lightIdentifiers identifiers: [UUID], fromSceneWithIdentifier sceneIdentifier: UUID) {
        guard scenes.contains(where: { $0.identifier == sceneIdentifier }) else {
            return
        }
        scenes[sceneIdentifier]?.lights.subtract(identifiers)
        print(activeLightIdentifiers)
        DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateLightsForSceneWith(identifier: sceneIdentifier) } }
    }

    public func set(name: String, forSceneWithIdentifier identifier: UUID) {
        guard let scene = scenes[identifier] else {
            print("Aurora: Unable to find scene with identifier", identifier)
            return
        }
        guard !name.isEmpty else {
            print("Aurora: Scene should not be empty")
            return
        }
        guard scene.name != name else {
            print("Aurora: Scene already has this name", name)
            return
        }

        scenes[identifier]?.name = name
        DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
    }

    public func set(effects: Scene.Effects?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.effects = effects
    }

    public func toggle(effects: Scene.Effects, forSceneWithIdentifier identifier: UUID) {
        fatalError("Not Implemented")
    }

    public func set(brightness: Float) {
        self.brightness = max(0.0, min(brightness, 1.0))
    }

    public func set(volume: Float) {
        self.volume = max(0.0, min(volume, 1.0))
        output.audio?.set(volume: self.volume)
    }
}
