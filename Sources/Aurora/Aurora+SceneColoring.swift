import Foundation

extension Aurora {
    public func set(coloringMode: Coloring.Mode, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.mode = coloringMode
    }

    public func set(coloringHue: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.hue = coloringHue
    }

    public func set(coloringRange: ClosedRange<Float>, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.range = coloringRange
    }

    public func set(coloringRangeMinimum: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.range.minimum = coloringRangeMinimum
    }

    public func set(coloringRangeMaximum: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.range.maximum = coloringRangeMaximum
    }

    public func set(coloringSpectrum: Spectrum, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.spectrum = coloringSpectrum
    }

    public func set(coloringSaturation: ClosedRange<Float>, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.saturation = coloringSaturation
    }

    public func set(coloringSaturationMinimum: Float, forSceneWithIdentifier identifier: UUID) {
         scenes[identifier]?.coloring.saturation.minimum = coloringSaturationMinimum
    }

    public func set(coloringSaturationMaximum: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.saturation.maximum = coloringSaturationMaximum
    }

    public func set(coloringBrightness: ClosedRange<Float>, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.brightness = coloringBrightness
    }

    public func set(coloringBrightnessMinimum: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.brightness.minimum = coloringBrightnessMinimum
    }

    public func set(coloringBrightnessMaximum: Float, forSceneWithIdentifier identifier: UUID) {
        scenes[identifier]?.coloring.brightness.maximum = coloringBrightnessMaximum
    }
}
