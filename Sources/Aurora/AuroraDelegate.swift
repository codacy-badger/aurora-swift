import Foundation

public protocol AuroraDelegate: AnyObject {
    func didUpdateConnectors()

    /// Called when new lights are added or one of the lights updates a name.
    func didUpdateLights()

    func didUpdateScenes()
    func didUpdateLightsForSceneWith(identifier: UUID)

    func didUpdateAudioLevel(current: Float, threshold: Float)
    func didUpdateVideoColor(hue: Float, saturation: Float, brightness: Float)

    /// Called when light's reachability changes
    func didUpdateReachabilityForLightsWith(identifiers: [UUID])
    /// Called when light state changes color
    func didUpdateColorsForLightsWith(identifiers: [UUID])

    func didReceive(event: Event)
}

extension AuroraDelegate {
    public func didUpdateConnectors() {}
    public func didUpdateLights() {}
    public func didUpdateScenes() {}

    public func didUpdateLightsForSceneWith(identifier: UUID) {}

    public func didUpdateAudioLevel(current: Float, threshold: Float) {}
    public func didUpdateVideoColor(hue: Float, saturation: Float, brightness: Float) {}

    public func didUpdateReachabilityForLightsWith(identifiers: [UUID]) {}
    public func didUpdateColorsForLightsWith(identifiers: [UUID]) {}

    public func didReceive(event: Event) {}
}
