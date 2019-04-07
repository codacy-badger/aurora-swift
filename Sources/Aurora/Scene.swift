import Foundation

public struct Scene: Identifiable, Equatable {
    public var name: String
    public let identifier: UUID

    public var lights: Set<UUID>

    public var input: Input.Settings?
    public var output: Output.Settings?

    public var hue: ValueScope?
    public var saturation: ValueScope?
    public var brightness: ValueScope?
    public var transition: ValueScope?

    public var effects: Effects?

    /// Context identifier for this scene.
    public var context: String?

    public init(name: String, identifier: UUID = UUID(), lights: Set<UUID> = [], input: Input.Settings? = nil, output: Output.Settings? = nil, hue: ValueScope? = nil, saturation: ValueScope? = nil, brightness: ValueScope? = nil, transition: ValueScope? = nil, effects: Effects? = nil, context: String? = nil) {
        self.name = name
        self.identifier = identifier
        self.lights = lights
        self.input = input
        self.output = output
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.transition = transition
        self.effects = effects
        self.context = context
    }
}

extension Scene {
    var requiresContiniousExecution: Bool {
        return input != nil
    }
}

extension Scene {
    public struct Effects: OptionSet, Codable, Equatable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let strobe = Effects(rawValue: 1 << 0)
    }
}

extension Collection where Element == Scene {
    public var timeInputScenes: [Scene] {
        return self.filter {
            guard let input = $0.input else { return false }
            if case Input.Settings.time = input { return true } else { return false }
        }
    }

    public var audioInputScenes: [Scene] {
        return self.filter {
            guard let input = $0.input else { return false }
            if case Input.Settings.audio = input { return true } else { return false }
        }
    }

    public var videoInputScenes: [Scene] {
        return self.filter {
            guard let input = $0.input else { return false }
            if case Input.Settings.video = input { return true } else { return false }
        }
    }

    public var audioOutputScenes: [Scene] {
        return self.filter {
            guard let output = $0.output else { return false }
            if case Output.Settings.audio = output { return true } else { return false }
        }
    }
}
