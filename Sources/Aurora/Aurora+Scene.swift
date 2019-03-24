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

    public func set(input: Input.Settings?, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.input != input {
            scenes[identifier]?.input = input
            refreshInputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }

    public func set(output: Output.Settings?, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.output != output {
            scenes[identifier]?.output = output
            refreshOutputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }

    public func set(hue: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.hue = hue
    }

    public func set(saturation: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.saturation = saturation
    }

    public func set(brightness: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.brightness = brightness
    }

    public func set(effects: Scene.Effects?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.effects = effects
    }

    public func set(transition: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.transition = transition
        refreshInputs()
    }
}
