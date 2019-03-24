import Foundation

extension Scene {
    public var randomHue: Float {
        return hue?.random ?? .random(in: .unitInterval)
    }

    public var randomBrightness: Float {
        return brightness?.random ?? .random(in: .unitInterval)
    }

    public var randomSaturation: Float {
        return saturation?.random ?? .random(in: .unitInterval)
    }

    public var randomTransition: Float {
        return transition?.random ?? 0.0
    }
}
