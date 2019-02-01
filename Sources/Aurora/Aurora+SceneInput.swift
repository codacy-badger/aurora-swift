import Foundation

extension Aurora {
    public func set(inputMode: Input.Mode, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.input.mode != inputMode {
            scenes[identifier]?.input.mode = inputMode
            refreshInputForSceneWith(identifier: identifier)
            delegates.forEach { $0.didUpdateScenes() }
        }
    }

    public func set(inputInterval: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.input.interval = inputInterval
        refreshInputForSceneWith(identifier: identifier)
    }

    public func set(inputTransition: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.input.transition = inputTransition
        refreshInputForSceneWith(identifier: identifier)
    }
}
