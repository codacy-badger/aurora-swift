import Foundation

extension Aurora {
    /// Should be called after setting scene input mode to sync inputs
    internal func refreshInputForSceneWith(identifier: UUID) {
        /// Remove old time loops that might still be in progress
        input.time?.remove(loop: identifier)
        removeUnusedInputs()

        if let scene = scenes[identifier], isActive(sceneWithIdentifier: identifier) {
            /// Refresh time input loop
            /// Start shared inputs
            switch scene.input.mode {
            case .none:
                print("Aurora: Refreshing input for mode `none` is not required")

            case .time:
                if input.time == nil, let timeInput = constructor?.constructTimeInput() {
                    input.time = timeInput
                    input.time?.start(onLoop: self.onTimeLoop)
                }
                input.time?.add(loop: identifier, duration: scene.input.interval)

            case .audio:
                if input.audio == nil, let audioInput = constructor?.constructAudioInput() {
                    input.audio = audioInput
                    input.audio?.start(onLevel: self.onAudioLevelChange)
                }

            case .video:
                if input.video == nil, let videoInput = constructor?.constructVideoInput() {
                    input.video = videoInput
                    input.video?.start(index: 0, onColor: self.onVideoColorChange)
                }
            }
        }
    }

    /// Checks if input is still needed, if removes it.
    internal func removeUnusedInputs() {
        if activeScenes.filter({ $0.input.mode == .time }).isEmpty {
            input.time = nil
        }
        if activeScenes.filter({ $0.input.mode == .audio }).isEmpty {
            input.audio = nil
        }
        if activeScenes.filter({ $0.input.mode == .video }).isEmpty {
            input.video = nil
        }
    }

    /// Time
    private func onTimeLoop(uuid: UUID) {
        print("Aurora: Time Loop", uuid)
        if let activeLightScene = scenes.first(where: { $0.identifier == uuid }), activeLightScene.input.mode == .time {
            let transformer = lightsTransformer(preset: activeLightScene)
            updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
        }
    }

    /// Audio
    private func onAudioLevelChange(level: Float) {
        print("Aurora: Audio Level", level)
        if input.audio?.processor.update(level: level) == true {
            print("Aurora: Audio Burst")
            activeScenes.filter({ $0.input.mode == .audio }).forEach { activeLightScene in
                let transformer = lightsTransformer(preset: activeLightScene)
                updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
            }
        }
        delegates.forEach { $0.didUpdateAudioLevel(current: input.audio?.processor.level ?? 0.0, threshold: input.audio?.processor.thresholdLevel ?? 0.0) }
    }

    /// Video
    private func onVideoColorChange(hue: Float, brightness: Float, saturation: Float) {
        if input.video?.processor.update(hue: hue, brightness: brightness, saturation: saturation) == true {
            print("Aurora: Video Burst")
            activeScenes.filter({ $0.input.mode == .video }).forEach { activeLightScene in
                let transformer = lightsTransformer(preset: activeLightScene, hue: hue, brightness: brightness, saturation: saturation)
                updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
            }
        }
        delegates.forEach { $0.didUpdateVideoColor(hue: hue, saturation: saturation, brightness: brightness) }
    }

    private func updateActiveReachableLightsFor(activeLightScene: Scene, with transformer: @escaping LightsTransformer) {
        switch mode {
        case .simplex:
            let activeLights = self.activeLights.reachable
            update(lights: activeLights, with: transformer)

        case .multiplex:
            let sceneActiveLights = self.activeLights(forSceneWithIdentifier: activeLightScene.identifier).reachable
            update(lights: sceneActiveLights, with: transformer)
        }
    }
}
