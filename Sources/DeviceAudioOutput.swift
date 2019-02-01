#if os(macOS) || os(iOS)
import AVFoundation
import Foundation

public class DeviceAudioOutput: AudioOutputable {
    private var player: AVAudioPlayer?

    public init() {}

    public func set(volume: Float) {
        self.player?.volume = volume
    }

    /// Plays 'mp3' track with given name and volume.
    public func play(track name: String, volume: Float) {
        print("Device Audio Output: Playing track", name)
        if
            let filePath: String = Bundle.main.path(forResource: name.filter({ $0 != " " }), ofType: "mp3"),
            let url: URL = URL(string: filePath),
            let audioPlayer: AVAudioPlayer = try? AVAudioPlayer(contentsOf: url) {
                self.player = audioPlayer
                self.player?.volume = volume
                self.player?.numberOfLoops = -1
                self.player?.prepareToPlay()
                self.player?.play()
        }
    }

    deinit {
        print("Device Audio Output: Deinit")
        self.player?.stop()
        self.player = nil
    }
}
#endif
