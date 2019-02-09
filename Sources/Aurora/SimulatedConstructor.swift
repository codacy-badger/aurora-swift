import Foundation

public class SimulatedConstructor: Constructable {
    public init() {
        print("SimulatedConstructor: Init")
    }

    /// MARK: Inputs
    public func constructTimeInput() -> TimeInputable? {
        return DeviceTimeInput()
    }

    public func constructAudioInput() -> AudioInputable? {
        return SimulatedAudioInput()
    }

    public func constructVideoInput() -> VideoInputable? {
        return SimulatedVideoInput()
    }

    /// MARK: Outputs

    public func constructAudioOutput() -> AudioOutputable? {
        return SimulatedAudioOutput()
    }

    public func constructConnectorFor(type: String) -> Connectable? {
        return SimulatedConnector(type: type)
    }

    deinit {
        print("SimulatedConstructor: Deinit")
    }
}
