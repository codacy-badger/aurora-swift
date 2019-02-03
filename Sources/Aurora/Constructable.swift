import Foundation

public protocol Constructable: AnyObject {
    func constructTimeInput() -> TimeInputable?
    func constructAudioInput() -> AudioInputable?
    func constructVideoInput() -> VideoInputable?
    func constructAudioOutput() -> AudioOutputable?
    func constructConnectorFor(type: String) -> Connectable?
}

extension Constructable {
    public func constructTimeInput() -> TimeInputable? {
        print("Aurora: Time Input requested but not supported")
        return nil
    }

    public func constructAudioInput() -> AudioInputable? {
        print("Aurora: Audio Input requested but not supported")
        return nil
    }

    public func constructVideoInput() -> VideoInputable? {
        print("Aurora: Video Input requested but not supported")
        return nil
    }

    public func constructAudioOutput() -> AudioOutputable? {
        print("Aurora: Video Input requested but not supported")
        return nil
    }

    public func constructConnectorFor(type: String) -> Connectable? {
        print("Aurora: Connector `\(type)` requested but not supported")
        return nil
    }
}
