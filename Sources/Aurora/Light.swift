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

    public struct Update: Codable, Equatable {
        internal let identifier: UUID
        internal let type: String
        internal let manufacturerIdentifier: String
        internal let bridgeIdentifier: String?
        internal let updates: State.Update
    }

    public internal(set) var identifier: UUID
    public internal(set) var name: String
    public internal(set) var type: String
    public internal(set) var state: State?
    /// Serial number or other manufactirer identifier
    public internal(set) var manufacturerIdentifier: String
    /// Bridge identifier like bridge's serial number
    /// Nil if light is not bridged
    public internal(set) var bridgeIdentifier: String?

    /// Model of the device
    public internal(set) var model: String?

    /// Reachability
    public var isReachable: Bool {
        return state != nil
    }

    internal init(identifier: UUID, name: String, type: String, state: State?, manufacturerIdentifier: String, bridgeIdentifier: String? = nil, model: String? = nil) {
        self.identifier = identifier
        self.name = name
        self.type = type
        self.state = state
        self.manufacturerIdentifier = manufacturerIdentifier
        self.bridgeIdentifier = bridgeIdentifier
        self.model = model
    }
    /// Updates lights properties and creates a state update
    /// Only neccessary changes are generated
    internal mutating func update(with changes: State.Update) -> Light.Update? {

        guard !changes.isEmpty else {
            return nil
        }

        let stateUpdate = State.Update(
            hue: changes.hue != state?.hue ? changes.hue : nil,
            saturation: changes.saturation != state?.saturation ? changes.saturation : nil,
            brightness: changes.brightness != state?.brightness ? changes.brightness : nil,
            isPowered: changes.isPowered != state?.isPowered ? changes.isPowered : nil,
            transitionTime: changes.transitionTime
        )

        guard !stateUpdate.isEmpty else {
            return nil
        }

        return Light.Update(
            identifier: identifier,
            type: type,
            manufacturerIdentifier: manufacturerIdentifier,
            bridgeIdentifier: bridgeIdentifier,
            updates: stateUpdate
        )
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
        return self.manufacturerIdentifier == light.manufacturerIdentifier && self.type == light.type && self.bridgeIdentifier == light.bridgeIdentifier
    }

    var forcedUnreachable: Light {
        var light = self
        light.state = nil
        return light
    }
}

extension Array where Element == Light {

    public var reachable: [Light] {
        return self.filter({ $0.isReachable })
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
