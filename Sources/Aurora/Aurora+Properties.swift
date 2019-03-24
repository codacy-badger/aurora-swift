import Foundation

extension Aurora {
    public func set(brightness: Float) {
        self.brightness = max(0.0, min(brightness, 1.0))
    }

    public func set(volume: Float) {
        self.volume = max(0.0, min(volume, 1.0))
        output.audio?.set(volume: self.volume)
    }
}
