import Foundation

public protocol AuroraDelegate: AnyObject {

    func didUpdateConnectors()
    func didUpdateLights()

    func didUpdateScenes()
    func didUpdateLightsForSceneWith(identifier: UUID)

    func didUpdateAudioLevel(current: Float, threshold: Float)
    func didUpdateVideoColor(hue: Float, saturation: Float, brightness: Float)
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
    public func didUpdateColorsForLightsWith(identifiers: [UUID]) {}

    public func didReceive(event: Event) {}
}
