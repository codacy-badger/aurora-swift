import Foundation

extension Scene {
    public var randomHue: Float {
        return random(from: hue)
    }

    public var randomBrightness: Float {
        return random(from: brightness)
    }

    public var randomSaturation: Float {
        return random(from: saturation)
    }

    public var randomTransition: Float {
        return randomTransition(from: transition)
    }

    private func random(from scope: ValueScope?) -> Float {
        guard let scope = scope else { return .random(in: .unitInterval) }
        switch scope {
        case let .constant(value):
            return value
        case let .range(value):
            return .random(in: value)
        case let .spectrum(value):
            return value.randomHue
        }
    }

    private func randomTransition(from scope: ValueScope?) -> Float {
        guard let scope = scope else { return 0.0 }
        switch scope {
        case let .constant(value):
            return value
        case let .range(value):
            return .random(in: value)
        case let .spectrum(value):
            return value.randomHue
        }
    }
}
