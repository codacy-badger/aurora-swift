import Foundation

extension Aurora {
    public func set(input: Input.Settings?, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.input != input {
            scenes[identifier]?.input = input
            refreshInputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }

    public func set(transition: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.transition = transition
        refreshInputs()
    }
}
