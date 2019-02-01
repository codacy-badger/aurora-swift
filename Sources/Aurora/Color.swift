import Foundation

public struct Color: Codable, Equatable {
    public var hue: Float
    public var saturation: Float
    public var brightness: Float

    /// Initializes a new Color struct with the provided HSB color parameters
    ///
    /// - parameter hue: The 360 degrees hue value represented as Float from 0.0 to 1.0
    /// - parameter saturation: The saturation value represented as Float from 0.0 to 1.0
    /// - parameter brightness: The brightness value represented as Float from 0.0 to 1.0
    /// - returns: Color struct with default alpha value of 1.0
    public init(hue: Float, saturation: Float, brightness: Float) {
        self.hue = max(0, min(hue, 1))
        self.saturation = max(0, min(saturation, 1))
        self.brightness = max(0, min(brightness, 1))
    }

    /// Initializes a new Color struct with the provided RGBA color parameters
    ///
    /// - parameter red: Red component value represented as Float from 0.0 to 1.0
    /// - parameter green: Green component represented as Float from 0.0 to 1.0
    /// - parameter blue: Blue component  value represented as Float from 0.0 to 1.0
    /// - returns: Color struct
    public init(red: Float, green: Float, blue: Float) {
        var hue: Float
        var saturation: Float
        var brightness: Float

        let minRGB: Float = min(red, min(green, blue))
        let maxRGB: Float = max(red, max(green, blue))

        if minRGB == maxRGB {
            hue = 0
            saturation = 0
            brightness = minRGB
        } else {
            let dValue: Float = (red == minRGB) ? green - blue : ((blue == minRGB) ? red - green : blue - red)
            let interimHue: Float = (red == minRGB) ? 3 : ((blue == minRGB) ? 1 : 5)
            hue = (interimHue - dValue / (maxRGB - minRGB)) / 6.0
            saturation = (maxRGB - minRGB) / maxRGB
            brightness = maxRGB
        }

        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }
}

extension Color {
    public func maxComponentOffset(with color: Color) -> Float {
        return [
            self.hue - color.hue,
            self.saturation - color.saturation,
            self.brightness - color.brightness
        ].map({ abs($0) }).max() ?? 0.0
    }
}
