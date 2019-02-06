import Foundation

extension ClosedRange: Codable where Bound == Float {
    enum CodableError: Error {
        case decodingFailed
    }

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let lowerBound = try container.decode(Bound.self)
        let upperBound = try container.decode(Bound.self)
        guard lowerBound <= upperBound else {
            throw CodableError.decodingFailed
        }
        self.init(uncheckedBounds: (lower: lowerBound, upper: upperBound))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.lowerBound)
        try container.encode(self.upperBound)
    }
}

extension ClosedRange where Bound == Float {
    public static let unitInterval: ClosedRange = 0.0...1.0
}

extension ClosedRange where Bound == Float {
    public var minimum: Float {
        get {
            return self.lowerBound
        }
        set {
            self = newValue...self.upperBound
        }
    }

    public var maximum: Float {
        get {
            return self.upperBound
        }
        set {
            self = self.lowerBound...newValue
        }
    }
}
