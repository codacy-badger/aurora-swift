import Foundation

public struct Light: Identifiable, Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case identifier
        case name
        case type
        case manufacturerIdentifier
        case bridgeIdentifier
        case model
    }

    public struct State: Codable, Equatable {
        public internal(set) var isPowered: Bool
        public internal(set) var hue: Float?
        public internal(set) var saturation: Float?
        public internal(set) var brightness: Float?

        public init(isPowered: Bool, hue: Float? = nil, saturation: Float? = nil, brightness: Float? = nil) {
            self.isPowered = isPowered
            self.hue = hue
            self.saturation = saturation
            self.brightness = brightness
        }
    }

    public struct Update: Codable, Equatable {
        public let identifier: UUID
        public let type: String
        public let manufacturerIdentifier: String
        public let bridgeIdentifier: String?
        public let state: State
        public let transitionTime: Float
    }

    public internal(set) var name: String
    public internal(set) var type: String
    /// Serial number or other unique manufacturer identifier
    public internal(set) var manufacturerIdentifier: String
    public internal(set) var identifier: UUID

    public internal(set) var state: State?

    /// Bridge identifier like bridge's serial number
    /// Nil if light is not bridged
    public internal(set) var bridgeIdentifier: String?

    /// Model of the device
    public internal(set) var model: String?

    /// Context
    public internal(set) var context: String?

    /// Reachability
    public var isReachable: Bool {
        return state != nil
    }

    public init(name: String, type: String, manufacturerIdentifier: String, identifier: UUID = UUID(), bridgeIdentifier: String? = nil, state: State? = nil, model: String? = nil, context: String? = nil) {
        self.name = name
        self.type = type
        self.manufacturerIdentifier = manufacturerIdentifier
        self.identifier = identifier
        self.bridgeIdentifier = bridgeIdentifier
        self.state = state
        self.model = model
        self.context = context
    }

    init?(attributes: [String: Any]) {
        guard let name = attributes[Attribute.name.rawValue] as? String else { return nil }
        guard let type = attributes[Attribute.type.rawValue] as? String else { return nil }
        guard let manufacturerIdentifier = attributes[Attribute.manufacturerIdentifier.rawValue] as? String else { return nil }

        let bridgeIdentifier: String? = attributes[Attribute.bridgeIdentifier.rawValue] as? String
        let model: String? = attributes[Attribute.model.rawValue] as? String
        let context: String? = attributes[Attribute.context.rawValue] as? String

        var state: State?

        if let isPowered = attributes[Attribute.power.rawValue] as? Bool {
            let hue: Float? = attributes[Attribute.hue.rawValue] as? Float
            let saturation: Float? = attributes[Attribute.saturation.rawValue] as? Float
            let brightness: Float? = attributes[Attribute.brightness.rawValue] as? Float
            state = State(isPowered: isPowered, hue: hue, saturation: saturation, brightness: brightness)
        }

        self.init(
            name: name,
            type: type,
            manufacturerIdentifier: manufacturerIdentifier,
            bridgeIdentifier: bridgeIdentifier,
            state: state,
            model: model,
            context: context
        )
    }

    /// Updates lights properties and creates an update
    internal mutating func update(from state: State, withTransitionTime transitionTime: Float) -> [String: Any] {
        var lightUpdate: [String: Any] = [
            Attribute.identifier.rawValue: identifier,
            Attribute.type.rawValue: type,
            Attribute.manufacturerIdentifier.rawValue: manufacturerIdentifier,
            Attribute.transitionTime.rawValue: transitionTime
        ]

        self.state?.isPowered = state.isPowered
        lightUpdate[Attribute.power.rawValue] = state.isPowered

        if let updatedHue = state.hue, self.state?.hue != updatedHue {
            self.state?.hue = updatedHue
            lightUpdate[Attribute.hue.rawValue] = updatedHue
        }

        if let updatedSaturation = state.saturation, self.state?.saturation != updatedSaturation {
            self.state?.saturation = updatedSaturation
            lightUpdate[Attribute.saturation.rawValue] = updatedSaturation
        }

        if let updatedBrightness = state.brightness, self.state?.brightness != updatedBrightness {
            self.state?.brightness = updatedBrightness
            lightUpdate[Attribute.brightness.rawValue] = updatedBrightness
        }

        if let bridgeIdentifier = bridgeIdentifier {
            lightUpdate[Attribute.bridgeIdentifier.rawValue] = bridgeIdentifier
        }

        return lightUpdate
    }

    /// Returns true if sync made changes
    mutating func sync(with light: Light) -> Bool {
        var hasChanges = false

        if self.name != light.name {
            self.name = light.name
            hasChanges = true
        }

        if self.state != light.state {
            self.state = light.state
            hasChanges = true
        }

        if self.model != light.model {
            self.model = light.model
            hasChanges = true
        }

        return hasChanges
    }

    func phisicallyEqual(to light: Light) -> Bool {
        return
            self.manufacturerIdentifier == light.manufacturerIdentifier &&
            self.type == light.type &&
            self.bridgeIdentifier == light.bridgeIdentifier &&
            self.context == light.context
    }

    var forcedUnreachable: Light {
        var light = self
        light.state = nil
        return light
    }
}

extension Array where Element == Light {
    public var reachable: [Light] {
        return self.filter { $0.isReachable }
    }

    public var forcedUnrechable: [Light] {
        return self.map { $0.forcedUnreachable }
    }

    public func forcedUnreachable(forType type: String) -> [Light] {
        return self.map { $0.type == type ? $0.forcedUnreachable : $0 }
    }

    mutating func sync(with lights: [Light]) -> Bool {
        /// Track changes
        var hasChanges = false
        lights.forEach { lightToSync in
            if let index = self.index(where: { $0.phisicallyEqual(to: lightToSync) }) {
                /// Light exists
                if self[index].sync(with: lightToSync) {
                    hasChanges = true
                }
            } else {
                /// New light
                self.append(lightToSync)
                hasChanges = true
            }
        }
        return hasChanges
    }
}
