import Foundation

extension Aurora: Codable {
    enum CodingKeys: String, CodingKey {
        case mode
        case lights
        case activeLightIdentifiers
        case scenes
        case activeSceneIdentifiers
        case connectors
        case brightness
        case volume
    }

    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let mode = try? values.decode(Mode.self, forKey: .mode)
        let lights = try? values.decode([Light].self, forKey: .lights)
        let activeLightIdentifiers = try? values.decode(Set<UUID>.self, forKey: .activeLightIdentifiers)
        let scenes = try? values.decode([Scene].self, forKey: .scenes)
        let activeSceneIdentifiers = try? values.decode(Set<UUID>.self, forKey: .activeSceneIdentifiers)
        let connectors = try? values.decode(Set<String>.self, forKey: .connectors)
        let brightness = try? values.decode(Float.self, forKey: .brightness)
        let volume = try? values.decode(Float.self, forKey: .volume)

        self.init(
            mode: mode ?? .simplex,
            lights: lights ?? [],
            activeLightIdentifiers: activeLightIdentifiers ?? [],
            scenes: scenes ?? [],
            activeSceneIdentifiers: activeSceneIdentifiers ?? [],
            connectors: connectors ?? [],
            brightness: brightness ?? 1.0,
            volume: volume ?? 1.0
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mode, forKey: .mode)
        if !lights.isEmpty {
            try container.encode(lights, forKey: .lights)
        }
        if !activeLightIdentifiers.isEmpty {
            try container.encode(activeLightIdentifiers, forKey: .activeLightIdentifiers)
        }
        if !scenes.isEmpty {
            try container.encode(scenes, forKey: .scenes)
        }
        if !activeSceneIdentifiers.isEmpty {
            try container.encode(activeSceneIdentifiers, forKey: .activeSceneIdentifiers)
        }
        if !connectors.isEmpty {
            try container.encode(connectors, forKey: .connectors)
        }
        try container.encode(brightness, forKey: .brightness)
        try container.encode(volume, forKey: .volume)
    }
}
