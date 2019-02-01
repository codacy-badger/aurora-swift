import Foundation

extension Aurora {

    public func set(outputMode: Output.Mode, forSceneWithIdentifier identifier: UUID) {
        if let scene = scenes[identifier], scene.output.mode != outputMode {
            scenes[identifier]?.output.mode = outputMode
            refreshOutputForSceneWith(identifier: identifier)
            delegates.forEach { $0.didUpdateScenes() }
        }
    }

    public func set(outputTrack: String?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.output.track = outputTrack
        refreshOutputForSceneWith(identifier: identifier)
    }

}
