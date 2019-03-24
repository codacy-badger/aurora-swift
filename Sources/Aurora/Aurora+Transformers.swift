import Foundation

internal typealias LightsTransformer = ([Light]) -> [(updatedLight: Light, update: [String: Any])]

extension Aurora {
    /// Updates lights from preset
    internal func lightsTransformer(preset: Scene) -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                var light = light
                let lightState = Light.State(
                    isPowered: (preset.effects?.contains(.strobe) ?? false) ? !(light.state?.isPowered ?? false) : true,
                    hue: preset.randomHue,
                    saturation: preset.randomSaturation,
                    brightness: preset.randomBrightness * (self?.brightness ?? 1.0)
                )
                let update = light.update(from: lightState, withTransitionTime: preset.randomTransition)
                return (light, update)
            }
        }
    }

    /// Updates lights from preset with monocolor
    internal func lightsTransformer(preset: Scene, hue: Float, brightness: Float, saturation: Float) -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                let saturation = saturation.clamped(to: preset.saturation)
                let brightness = saturation.clamped(to: preset.brightness) * (self?.brightness ?? 1.0)
                var light = light
                let lightState = Light.State(isPowered: true, hue: hue, saturation: saturation, brightness: brightness)
                let update = light.update(from: lightState, withTransitionTime: preset.randomTransition)
                return (light, update)
            }
        }
    }

    internal func lightsTransformer(power: Bool) -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                var light = light

                let lightState: Light.State

                if power {
                    lightState = Light.State(
                        isPowered: true,
                        hue: nil,
                        saturation: 1.0,
                        brightness: 1.0 * (self?.brightness ?? 1.0)
                    )
                } else {
                    lightState = Light.State(
                        isPowered: false,
                        hue: nil,
                        saturation: nil,
                        brightness: nil
                    )
                }

                let update = light.update(from: lightState, withTransitionTime: 1.0)
                return (light, update)
            }
        }
    }

    internal func randomLightsTransformer() -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                var light = light
                let lightState = Light.State(
                    isPowered: true,
                    hue: Float.random(in: 0...1),
                    saturation: Float.random(in: 0...1),
                    brightness: Float.random(in: 0...1) * (self?.brightness ?? 1.0)
                )
                let update = light.update(from: lightState, withTransitionTime: Float.random(in: 0...5))
                return (light, update)
            }
        }
    }
}
