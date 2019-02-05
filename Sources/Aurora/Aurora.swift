import Foundation

public final class Aurora {
    public enum Mode: String, Codable, Equatable {
        /// Only one active scene is allowed, using global active lights selection.
        case simplex
        /// Multiple active scenes allowed, per scene active lights selection
        case multiplex
    }

    public internal(set) var mode: Mode

    public internal(set) var lights: [Light]
    var activeLightIdentifiers: Set<UUID>

    public internal(set) var scenes: [Scene]
    var activeSceneIdentifiers: Set<UUID>

    /// should be internal set
    public internal(set) var brightness: Float
    public internal(set) var volume: Float

    public internal(set) var delegates: [AuroraDelegate]

    var input: Input
    var output: Output

    var transformatorLock: Bool

    public internal(set) var connectors: Set<String>
    var attachedConnectors: [Connectable]

    public weak var constructor: Constructable?

    public init(mode: Mode = .simplex, lights: [Light] = [], activeLightIdentifiers: Set<UUID> = [], scenes: [Scene] = [], activeSceneIdentifiers: Set<UUID> = [], connectors: Set<String> = [], brightness: Float = 1.0, volume: Float = 1.0) {
        self.mode = mode
        self.lights = lights
        self.activeLightIdentifiers = activeLightIdentifiers
        self.scenes = scenes
        self.activeSceneIdentifiers = activeSceneIdentifiers
        self.brightness = brightness
        self.volume = volume
        delegates = []
        input = Input()
        output = Output()
        transformatorLock = false
        self.connectors = connectors
        self.attachedConnectors = []
    }
}
