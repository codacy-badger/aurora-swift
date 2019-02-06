import Foundation

extension Aurora {
    func refreshOutputs() {
        if activeScenes.filter({ $0.output.mode == .audio }).filter({ $0.output.track != nil }).isEmpty {
            output.audio = nil
        }

        guard mode == .simplex, let scene = scene else {
            print("Aurora: Output not required, no active scenes found")
            return
        }

        switch scene.output.mode {
        case .none:
            print("No output")

        case .audio:
            if let track = scene.output.track, let audioOutput = constructor?.constructAudioOutput() {
                print("Aurora: Building Audio Output")
                output.audio = audioOutput
                output.audio?.play(track: track, volume: self.volume)
            }
        }
    }
}
