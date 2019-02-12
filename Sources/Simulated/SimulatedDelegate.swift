import Aurora
import Foundation

public class SimulatedDelegate: AuroraDelegate {
    public enum Update: Equatable {
        case didUpdateConnectors
        case didUpdateLights
        case didUpdateScenes
        case didUpdateLightsForSceneWith(identifier: UUID)
        case didUpdateAudioLevel(current: Float, threshold: Float)
        case didUpdateVideoColor(hue: Float, saturation: Float, brightness: Float)
        case didUpdateColorsForLightsWith(identifiers: [UUID])
        case didReceive(event: Event)
    }

    public private(set) var updates: [Update] = []

    public init() {}

    /// MARK: AuroraDelegate

    public func didUpdateConnectors() {
        updates.append(.didUpdateConnectors)
    }

    public func didUpdateLights() {
        updates.append(.didUpdateLights)
    }

    public func didUpdateScenes() {
        updates.append(.didUpdateScenes)
    }

    public func didUpdateLightsForSceneWith(identifier: UUID) {
        updates.append(.didUpdateScenes)
    }

    public func didUpdateAudioLevel(current: Float, threshold: Float) {
        updates.append(.didUpdateAudioLevel(current: current, threshold: threshold))
    }

    public func didUpdateVideoColor(hue: Float, saturation: Float, brightness: Float) {
        updates.append(.didUpdateVideoColor(hue: hue, saturation: saturation, brightness: brightness))
    }

    public func didUpdateColorsForLightsWith(identifiers: [UUID]) {
        updates.append(.didUpdateColorsForLightsWith(identifiers: identifiers))
    }

    public func didReceive(event: Event) {
        updates.append(.didReceive(event: event))
    }
}
