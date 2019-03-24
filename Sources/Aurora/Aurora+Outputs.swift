import Foundation

extension Aurora {
    func refreshOutputs() {
        if activeScenes.audioOutputScenes.isEmpty {
            output.audio = nil
        }

        guard mode == .simplex, let scene = scene else {
            print("Aurora: Output not required, no active scenes found")
            return
        }

        switch scene.output {
        case let .some(.audio(settings)):
            if let audioOutput = outputGenerator?.audio() {
                print("Aurora: Building Audio Output")
                output.audio = audioOutput
                output.audio?.play(track: settings.track, volume: self.volume)
            }
        default:
            print("No output")
        }
    }
}
