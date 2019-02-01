import Foundation

public struct Scene: Codable, Identifiable, Equatable {

    public struct Effects: OptionSet, Codable, Equatable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let strobe = Effects(rawValue: 1 << 0)
    }

    public let identifier: UUID
    public var name: String
    public var lights: Set<UUID>

    public var input: Input.Settings
    public var output: Output.Settings
    public var coloring: Coloring
    public var effects: Effects

    public init(identifier: UUID, name: String, lights: Set<UUID>, input: Input.Settings, output: Output.Settings, coloring: Coloring, effects: Effects) {
        self.identifier = identifier
        self.name = name
        self.lights = lights
        self.input = input
        self.output = output
        self.coloring = coloring
        self.effects = effects
    }
}
