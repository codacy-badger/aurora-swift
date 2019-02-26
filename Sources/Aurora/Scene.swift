import Foundation

public struct Scene: Codable, Identifiable, Equatable {
    public struct Effects: OptionSet, Codable, Equatable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let strobe = Effects(rawValue: 1 << 0)
    }

    public var name: String
    public let identifier: UUID

    public var lights: Set<UUID>

    public var input: Inputs.Settings
    public var output: Outputs.Settings
    public var coloring: Coloring
    public var effects: Effects

    public init(name: String, identifier: UUID = UUID(), lights: Set<UUID> = [], input: Inputs.Settings = Inputs.Settings(), output: Outputs.Settings = Outputs.Settings(), coloring: Coloring = Coloring(), effects: Effects = []) {
        self.name = name
        self.identifier = identifier
        self.lights = lights
        self.input = input
        self.output = output
        self.coloring = coloring
        self.effects = effects
    }
}
