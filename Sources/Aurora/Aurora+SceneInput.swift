import Foundation

extension Aurora {
    public func set(inputMode: Input.Mode, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.input.mode != inputMode {
            scenes[identifier]?.input.mode = inputMode
            refreshInputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }

    public func set(inputInterval: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.input.interval = inputInterval
        refreshInputs()
    }

    public func set(inputTransition: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.input.transition = inputTransition
        refreshInputs()
    }
}
