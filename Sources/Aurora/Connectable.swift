import Foundation

public protocol Connectable: class {

    /// Type of device connection supported by this connector.
    static var type: String { get }

    /// API for sending light updates.
    func perform(lightUpdate: Light.Update)

    /// API for sending events to connector.
    /// At least 'event' attribute is required plus one of the attributes to update
    func send(event: Event)

    /// Connection
    func connect(onSync: @escaping ([Light]) -> Void, onEvent: @escaping (Event) -> Void)
}
