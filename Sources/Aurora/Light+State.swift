import Foundation

extension Light {
    public struct State: Codable, Equatable {

        internal struct Update: Codable, Equatable {
            internal let hue: Float?
            internal let saturation: Float?
            internal let brightness: Float?
            internal let isPowered: Bool?
            internal let transitionTime: Float

            internal init(hue: Float? = nil, saturation: Float? = nil, brightness: Float? = nil, isPowered: Bool? = nil, transitionTime: Float = 0.0) {
                self.hue = hue
                self.saturation = saturation
                self.brightness = brightness
                self.isPowered = isPowered
                self.transitionTime = transitionTime
            }

            public var isEmpty: Bool {
                return hue == nil && saturation == nil && brightness == nil && isPowered == nil
            }
        }

        public internal(set) var hue: Float
        public internal(set) var saturation: Float
        public internal(set) var brightness: Float
        public internal(set) var isPowered: Bool

        public var color: Color {
            return Color(hue: hue, saturation: saturation, brightness: brightness)
        }
    }
}
