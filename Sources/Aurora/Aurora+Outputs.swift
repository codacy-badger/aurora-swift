import Foundation

extension Aurora {

    public func refreshOutputForSceneWith(identifier: UUID) {

        removeUnusedOutputs()

        guard let scene = scenes.first(where: { $0.identifier == identifier }) else {
            print("Aurora: Unable to find scene with identifier", identifier)
            return
        }

        guard isActive(sceneWithIdentifier: identifier) else {
            print("Aurora: Refreshing output for inactive scene \(identifier) is not required")
            return
        }

        switch scene.output.mode {
        case .none:
            print("No output")
        case .audio:
            if mode == .simplex, let track = scene.output.track, let audioOutput = constructor?.constructAudioOutput() {
                print("Aurora: Building Audio Output")
                output.audio = audioOutput
                output.audio?.play(track: track, volume: self.volume)
            }
        }
    }

    internal func removeUnusedOutputs() {
        if activeScenes.filter({ $0.output.mode == .audio }).filter({ $0.output.track != nil }).isEmpty {
            output.audio = nil
        }
    }
}
