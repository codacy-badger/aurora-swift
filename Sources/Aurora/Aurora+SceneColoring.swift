import Foundation

extension Aurora {
    public func set(hue: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.hue = hue
    }

    public func set(saturation: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.saturation = saturation
    }

    public func set(brightness: ValueScope?, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.brightness = brightness
    }
}
