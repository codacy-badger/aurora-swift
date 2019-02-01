import Foundation

extension ClosedRange: Codable where Bound == Float {
    enum CodableError: Error {
        case decodingFailed
    }

    public init(from decoder: Decoder) throws {
        let stringValue = try decoder.singleValueContainer().decode(String.self)
        let values: [Float] = stringValue.components(separatedBy: "...").compactMap({ Float($0) })
        if let lowerBound = values.first, let upperBound = values.last {
            self = lowerBound...upperBound
        } else {
            throw CodableError.decodingFailed
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(lowerBound)...\(upperBound)")
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
