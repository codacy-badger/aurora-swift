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
}

extension ValueScope: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self = .constant(value)
    }
}
