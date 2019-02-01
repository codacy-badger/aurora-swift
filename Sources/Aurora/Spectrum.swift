import Foundation

public struct Spectrum: OptionSet, Codable, Equatable {
    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = max(0, min(127, rawValue))
    }

    public static let none = Spectrum(rawValue: 0)

    public static let red = Spectrum(rawValue: 1 << 0) // 1
    public static let orange = Spectrum(rawValue: 1 << 1) // 2
    public static let yellow = Spectrum(rawValue: 1 << 2) // 4
    public static let green = Spectrum(rawValue: 1 << 3) // 8
    public static let cyan = Spectrum(rawValue: 1 << 4) // 16
    public static let blue = Spectrum(rawValue: 1 << 5) // 32
    public static let violet = Spectrum(rawValue: 1 << 6) // 64

    public static let allColors = Spectrum(rawValue: 127)

    public static let elements: [Spectrum] = [.red, .orange, .yellow, .green, .cyan, .blue, .violet]

    private static let ranges: [(Spectrum, ClosedRange<Float>)] = [
        (.red, 0.0 ... 0.055),
        (.orange, 0.08 ... 0.125),
        (.yellow, 0.138 ... 0.166),
        (.green, 0.25 ... 0.416),
        (.cyan, 0.472 ... 0.500),
        (.blue, 0.527 ... 0.694),
        (.violet, 0.75 ... 0.888)
    ]

    public var randomHue: Float {
        let colors = Spectrum.ranges.filter { self.contains($0.0) }
        guard !colors.isEmpty else {
            return 0.0
        }
        if let color = colors.randomElement() {
            return Float.random(in: color.1)
        }
        return 0.0
    }
}
