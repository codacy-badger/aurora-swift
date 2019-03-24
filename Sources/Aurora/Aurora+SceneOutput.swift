import Foundation

extension Aurora {
    public func set(output: Output.Settings, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.output != output {
            scenes[identifier]?.output = output
            refreshOutputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }
}
