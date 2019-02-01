import Foundation

public struct AudioProcessor {
    /// Audio level, should be 0 at init.
    internal var level: Float = 0.0
    /// Auto audio threshold level, should be 0 at init.
    internal var thresholdLevel: Float = 0.0
    /// Auto audio threshold minimum level, should be around 0.1 at init.
    private var thresholdMinimumLevel: Float = 0.05
    /// Audio exponent, should be 1.0 at init.
    private var audioExponent: Float = 1.0
    /// Audio level cool down, should be false at init.
    private var audioLevelIsCoolingDown: Bool = false

    public init() {}

    /// Returns true if threshold exceeded
    public mutating func update(level: Float) -> Bool {
        self.level = level
        if level > thresholdLevel {
            thresholdLevel = level
        } else {
            /// Make autoAudioThresholdLevel lower with every tick, limiting at 0.0
            thresholdLevel -= 0.000_5 * audioExponent
            if thresholdLevel < thresholdMinimumLevel {
                thresholdLevel = thresholdMinimumLevel
            }
            audioExponent += 1.0
        }

        if level < thresholdLevel { audioLevelIsCoolingDown = false }
        if audioLevelIsCoolingDown == true {
            return false
        }

        if level >= thresholdLevel {
            audioExponent = 1.0
            thresholdLevel += 0.1
            audioLevelIsCoolingDown = true

            /// Threshold exceeded
            return true
        }
        return false
    }
}
