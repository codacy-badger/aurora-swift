import Foundation

extension Aurora {
    public func set(outputMode: Output.Mode, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.output.mode != outputMode {
            scenes[identifier]?.output.mode = outputMode
            refreshOutputs()
            DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateScenes() } }
        }
    }

    public func set(outputTrack: String?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.output.track = outputTrack
        refreshOutputs()
    }
}
