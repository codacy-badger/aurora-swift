import Foundation

public enum ValueScope: Codable, Equatable {
    enum Key: CodingKey {
        case constant
        case range
        case spectrum
    }

    enum CodingError: Error {
        case unknownValue
    }

    case constant(Float)
    case range(ClosedRange<Float>)
    case spectrum(Spectrum)

    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: Key.self), let rawValue = try? container.decode(Float.self, forKey: .constant) {
            self = .constant(rawValue)
            return
        }

        if let container = try? decoder.container(keyedBy: Key.self), let rawValue = try? container.decode(ClosedRange<Float>.self, forKey: .range) {
            self = .range(rawValue)
            return
        }

        if let container = try? decoder.container(keyedBy: Key.self), let rawValue = try? container.decode(Spectrum.self, forKey: .range) {
            self = .spectrum(rawValue)
            return
        }

        throw CodingError.unknownValue
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .constant(let value):
            var container = encoder.container(keyedBy: Key.self)
            try container.encode(value, forKey: .constant)
        case .range(let value):
            var container = encoder.container(keyedBy: Key.self)
            try container.encode(value, forKey: .range)
        case .spectrum(let value):
            var container = encoder.container(keyedBy: Key.self)
            try container.encode(value, forKey: .spectrum)
        }
    }

    public static func == (lhs: ValueScope, rhs: ValueScope) -> Bool {
        switch (rhs, lhs) {
        case (.constant, .constant), (.range, .range), (.spectrum, .spectrum):
            return true
        default:
            return false
        }
    }
}

extension ValueScope: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self = .constant(value)
    }
}

extension ValueScope {
    public var random: Float {
        switch self {
        case let .constant(value):
            return value
        case let .range(value):
            return .random(in: value)
        case let .spectrum(value):
            return value.randomHue
        }
    }
}

extension Float {
    public func clamped(to scope: ValueScope?) -> Float {
        switch scope {
        case let .some(.constant(value)):
            return value
        case let .some(.range(value)):
            return min(value.upperBound, max(self, value.lowerBound))
        case .some(.spectrum):
            /// No spectrum support yet
            return self
        case .none:
            return self
        }
    }
}
