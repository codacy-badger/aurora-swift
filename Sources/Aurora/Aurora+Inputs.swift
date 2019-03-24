import Foundation

extension Aurora {
    /// Should be called after setting scene input mode to sync inputs
    internal func refreshInputs() {
        /// Remove unused inputs
        if activeScenes.timeInputScenes.isEmpty {
            input.time = nil
        }
        if activeScenes.audioInputScenes.isEmpty {
            input.audio = nil
        }
        if activeScenes.videoInputScenes.isEmpty {
            input.video = nil
        }

        switch mode {
        case .simplex:
            scenes.forEach {
                input.time?.remove(loop: $0.identifier)
            }
        case .multiplex:
            inactiveScenes.forEach {
                input.time?.remove(loop: $0.identifier)
            }
        }

        /// Sync inputs for active scenes. If input time does not exist add it.
        activeScenes.forEach { scene in
            switch scene.input {
            case let .some(.time(settings)):
                print(settings)
                if input.time == nil, let timeInput = inputGenerator?.time() {
                    input.time = timeInput
                    input.time?.start(onLoop: self.onTimeLoop)
                }
                input.time?.add(loop: scene.identifier, duration: settings.interval)

            case let .some(.audio(settings)):
                print(settings)
                if input.audio == nil, let audioInput = inputGenerator?.audio() {
                    input.audio = audioInput
                    input.audio?.start(onLevel: self.onAudioLevelChange)
                }

            case let .some(.video(settings)):
                print(settings)
                if input.video == nil, let videoInput = inputGenerator?.video() {
                    input.video = videoInput
                    input.video?.start(index: 0, onColor: self.onVideoColorChange)
                }
            case .none:
                print("Aurora: Refreshing input for mode `none` is not required")
            }
        }
    }

    /// Time
    private func onTimeLoop(uuid: UUID) {
        print("Aurora: Time Loop", uuid)
        if let activeLightScene = scenes.first(where: { $0.identifier == uuid }), let input = activeLightScene.input {
            if case .time = input {
                let transformer = lightsTransformer(preset: activeLightScene)
                updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
            }
        }
    }

    /// Audio
    private func onAudioLevelChange(level: Float) {
        print("Aurora: Audio Level", level)
        if audioProcessor.update(level: level) == true {
            print("Aurora: Audio Burst")
            activeScenes.forEach { activeLightScene in
                if let input = activeLightScene.input, case .audio = input {
                    let transformer = lightsTransformer(preset: activeLightScene)
                    updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
                }

            }
        }
        DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateAudioLevel(current: self.audioProcessor.level, threshold: self.audioProcessor.thresholdLevel) } }
    }

    /// Video
    private func onVideoColorChange(hue: Float, brightness: Float, saturation: Float) {
        if videoProcessor.update(hue: hue, brightness: brightness, saturation: saturation) == true {
            print("Aurora: Video Burst")
            activeScenes.forEach { activeLightScene in
                if let input = activeLightScene.input, case .video = input {
                    let transformer = lightsTransformer(preset: activeLightScene, hue: hue, brightness: brightness, saturation: saturation)
                    updateActiveReachableLightsFor(activeLightScene: activeLightScene, with: transformer)
                }
            }
        }
        DispatchQueue.main.async { self.delegates.forEach { $0.didUpdateVideoColor(hue: hue, saturation: saturation, brightness: brightness) } }
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
