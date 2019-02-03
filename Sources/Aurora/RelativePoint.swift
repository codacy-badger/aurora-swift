import Foundation

#if os(macOS)
import CoreGraphics
#endif

/// RelativePoint struct that represents relation between point and size
public struct RelativePoint: CustomStringConvertible, Equatable {
    /// X coordinate represented as Double from 0.0 to 1.0
    public var relativeX: Double

    /// Y coordinate represented as Double from 0.0 to 1.0
    public var relativeY: Double

    /// Initializes a new RelativePoint struct with X and Y relative coordinates
    ///
    /// - parameter x: The X coordinate represented as Double from 0.0 to 1.0
    /// - parameter y: The Y coordinate represented as Double from 0.0 to 1.0
    /// - returns: RelativePoint struct
    public init(relativeX: Double, relativeY: Double) {
        self.relativeX = relativeX
        self.relativeY = relativeY
    }

    public func with(offsetX: Double, offsetY: Double) -> RelativePoint {
        return RelativePoint(relativeX: self.relativeX + offsetX, relativeY: self.relativeY + offsetY)
    }

    /// Description
    public var description: String { return ("RelativePoint - X:\(relativeX), Y:\(relativeY)") }

    #if os(macOS)

    /// Initializes a new RelativePoint struct with CGPoint and CGSize
    ///
    /// - parameter point: Coordinates in a target object
    /// - parameter size: Size of a target object
    /// - returns: RelativePoint struct
    public init(point: CGPoint, size: CGSize) {
        relativeX = Double(point.x) / Double(size.width)
        relativeY = Double(point.y) / Double(size.height)
    }
    #endif

    /// Create from center point, 12-point circle cluster, excluding point that are out of bounds
    public func cluster(relativeGap: Double) -> [RelativePoint] {
        let halfGap = relativeGap / 2
        /// Top

        return [
            self.with(offsetX: 0, offsetY: +relativeGap),
            /// MidTop
            self.with(offsetX: -halfGap, offsetY: +halfGap),
            self.with(offsetX: 0, offsetY: +halfGap),
            self.with(offsetX: +halfGap, offsetY: +halfGap),
            /// Center
            self.with(offsetX: -relativeGap, offsetY: 0),
            self.with(offsetX: -halfGap, offsetY: 0),
            self,
            self.with(offsetX: +halfGap, offsetY: 0),
            self.with(offsetX: +relativeGap, offsetY: 0),
            /// MidBottom
            self.with(offsetX: -halfGap, offsetY: -halfGap),
            self.with(offsetX: 0, offsetY: -halfGap),
            self.with(offsetX: +halfGap, offsetY: -halfGap),
            /// Bottom
            self.with(offsetX: 0, offsetY: -relativeGap)
        ].filter(notOutOfBoundsFilter)
    }

    private func notOutOfBoundsFilter(point: RelativePoint) -> Bool {
        return point.relativeX >= 0.0 && point.relativeX <= 1.0 && point.relativeY >= 0.0 && point.relativeY <= 1.0
    }
}

#if os(macOS)
extension CGPoint {
    /// Initializes a new CGPoint with RelativePoint and CGSize
    ///
    /// - parameter relativePoint: relative coordinates in a target object
    /// - parameter size: Size of a target object
    /// - returns: RelativePoint struct
    public init(_ relativePoint: RelativePoint, size: CGSize) {
        self.init()
        x = CGFloat(relativePoint.relativeX) * size.width
        y = CGFloat(relativePoint.relativeY) * size.height
    }
}
#endif
