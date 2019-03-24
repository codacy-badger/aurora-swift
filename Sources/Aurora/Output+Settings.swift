import Foundation

extension Output {
    public enum Settings: Codable, Equatable {
        case audio(AudioOutputSettings)

        enum Key: CodingKey {
            case audio
        }

        enum CodingError: Error {
            case unknownValue
        }

        public init(from decoder: Decoder) throws {
            if let container = try? decoder.container(keyedBy: Key.self), let settings = try? container.decode(AudioOutputSettings.self, forKey: .audio) {
                self = .audio(settings)
                return
            }

            throw CodingError.unknownValue
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .audio(let value):
                var container = encoder.container(keyedBy: Key.self)
                try container.encode(value, forKey: .audio)
            }
        }
    }
}

public struct AudioOutputSettings: Codable, Equatable {
    public static func track(_ name: String) -> AudioOutputSettings {
        return AudioOutputSettings(track: name)
    }

    public var track: String

    public init(track: String) {
        self.track = track
    }
}
