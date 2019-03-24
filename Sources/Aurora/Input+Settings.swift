import Foundation

extension Input {
    public enum Settings: Codable, Equatable, CaseIterable {
        case time(TimeInputSettings)
        case audio(AudioInputSettings)
        case video(VideoInputSettings)

        public static var allCases: [Input.Settings] {
            return [.time(.interval(1.0)), .audio(.source()), .video(.source())]
        }

        enum Key: CodingKey {
            case time
            case audio
            case video
        }

        enum CodingError: Error {
            case unknownValue
        }

        public init(from decoder: Decoder) throws {
            if let container = try? decoder.container(keyedBy: Key.self), let settings = try? container.decode(TimeInputSettings.self, forKey: .time) {
                self = .time(settings)
                return
            }

            if let container = try? decoder.container(keyedBy: Key.self), let settings = try? container.decode(AudioInputSettings.self, forKey: .audio) {
                self = .audio(settings)
                return
            }

            if let container = try? decoder.container(keyedBy: Key.self), let settings = try? container.decode(VideoInputSettings.self, forKey: .video) {
                self = .video(settings)
                return
            }

            throw CodingError.unknownValue
        }

        public func encode(to encoder: Encoder) throws {
            switch self {
            case .time(let value):
                var container = encoder.container(keyedBy: Key.self)
                try container.encode(value, forKey: .time)
            case .audio(let value):
                var container = encoder.container(keyedBy: Key.self)
                try container.encode(value, forKey: .audio)
            case .video(let value):
                var container = encoder.container(keyedBy: Key.self)
                try container.encode(value, forKey: .video)
            }
        }
    }

//    public struct Settings: Codable, Equatable {
//        public var mode: Mode
//        /// Time between bursts
//        public var interval: Float
//
//        public init(mode: Mode = .none, interval: Float = 1.0) {
//            self.mode = mode
//            self.interval = interval
//        }
//    }
}

public struct TimeInputSettings: Codable, Equatable {
    public static func interval(_ seconds: Float) -> TimeInputSettings {
        return TimeInputSettings(interval: seconds)
    }

    public var interval: Float

    public init(interval: Float) {
        self.interval = interval
    }
}

public struct AudioInputSettings: Codable, Equatable {
    public static func source(_ name: String? = nil) -> AudioInputSettings {
        return AudioInputSettings(source: name)
    }

    public var source: String?

    public init(source: String?) {
        self.source = source
    }
}

public struct VideoInputSettings: Codable, Equatable {
    public static func source(_ name: String? = nil) -> VideoInputSettings {
        return VideoInputSettings(source: name)
    }

    public var source: String?

    public init(source: String?) {
        self.source = source
    }
}
