import Foundation

public protocol Connectable: AnyObject {
    /// Type of device connection supported by this connector.
    var type: String { get }

    /// Connection
    func connect(onSync: @escaping ([[String: Any]]) -> Void, onEvent: @escaping ([String: Any]) -> Void)

    /// Performs light update with given parameters
    /// - parameter lightUpdate: dictionary with update parameters
    ///     - manufacturerIdentifier: required unique device identifier
    ///     - bridgeIdentifier: optional bridge identifier
    ///     - state: required Color and Power state
    func perform(lightUpdate: [String: Any])

    /// Send events to connector.
    func send(event: String, payload: Any?)
}
