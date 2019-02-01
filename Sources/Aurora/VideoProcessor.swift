import Foundation

public struct VideoProcessor {
    public var hue: Float = 0.0
    public var brightness: Float = 0.0
    public var saturation: Float = 0.0

    public init() {}

    /// Update color, returns true of it's a significant change
    public mutating func update(hue: Float, brightness: Float, saturation: Float) -> Bool {
        let threshold: Float = 0.0001
        if abs(self.hue - hue) >= threshold || abs(self.brightness - brightness) >= threshold || abs(self.saturation - saturation) >= threshold {
            self.hue = hue
            self.brightness = brightness
            self.saturation = saturation
            return true
        }
        return false
    }
}
