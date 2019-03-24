import Foundation

extension Scene: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case identifier
        case lights
        case input
        case output
        case hue
        case saturation
        case brightness
        case transition
        case effects
        case context
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        /// Required
        let name = try values.decode(String.self, forKey: .name)
        let identifier = try values.decode(UUID.self, forKey: .identifier)
        /// Optionals
        let lights = try? values.decode(Set<UUID>.self, forKey: .lights)
        let input = try? values.decode(Input.Settings.self, forKey: .input)
        let output = try? values.decode(Output.Settings.self, forKey: .output)
        let hue = try? values.decode(ValueScope.self, forKey: .hue)
        let saturation = try? values.decode(ValueScope.self, forKey: .saturation)
        let brightness = try? values.decode(ValueScope.self, forKey: .brightness)
        let transition = try? values.decode(ValueScope.self, forKey: .transition)
        let effects = try? values.decode(Scene.Effects.self, forKey: .effects)
        let context = try? values.decode(String.self, forKey: .context)

        self.init(
            name: name,
            identifier: identifier,
            lights: lights ?? [],
            input: input,
            output: output,
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            transition: transition,
            effects: effects,
            context: context
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        /// Required
        try container.encode(name, forKey: .name)
        try container.encode(identifier, forKey: .identifier)
        /// Optionals
        if !lights.isEmpty {
            try container.encode(lights, forKey: .lights)
        }
        try? container.encode(input, forKey: .input)
        try? container.encode(output, forKey: .output)
        try? container.encode(hue, forKey: .hue)
        try? container.encode(saturation, forKey: .saturation)
        try? container.encode(brightness, forKey: .brightness)
        try? container.encode(transition, forKey: .transition)
        try? container.encode(effects, forKey: .effects)
        try? container.encode(context, forKey: .context)
    }
}
