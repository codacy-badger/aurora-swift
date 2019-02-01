import Foundation

public struct Coloring: Codable, Equatable {

    public enum Mode: String, Codable, Equatable {
        case hue, range, spectrum
    }

    public var mode: Mode

    public var hue: Float
    public var range: ClosedRange<Float>
    public var spectrum: Spectrum

    public var saturation: ClosedRange<Float>
    public var brightness: ClosedRange<Float>

    public init(mode: Mode, hue: Float, range: ClosedRange<Float>, spectrum: Spectrum, saturation: ClosedRange<Float>, brightness: ClosedRange<Float>) {
        self.mode = mode
        self.hue = max(0.0, min(1.0, hue))
        self.range = range.clamped(to: .unitInterval)
        self.spectrum = spectrum
        self.saturation = saturation.clamped(to: .unitInterval)
        self.brightness = brightness.clamped(to: .unitInterval)
    }

    public var randomHue: Float {
        switch self.mode {
        case .hue:
            return hue
        case .range:
            return .random(in: range)
        case .spectrum:
            return spectrum.randomHue
        }
    }

    public var randomBrightness: Float {
        return .random(in: brightness)
    }

    public var randomSaturation: Float {
        return .random(in: saturation)
    }
}
