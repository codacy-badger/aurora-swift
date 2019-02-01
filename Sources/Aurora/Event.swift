import Foundation

public struct Event: Equatable {
    public let name: String
    public let type: String
    public let payload: Any?

    public init(name: String, type: String, payload: Any? = nil) {
        self.name = name
        self.type = type
        self.payload = payload
    }

    public static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}
