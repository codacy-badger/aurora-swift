//
//  Aurora+Transformers.swift
//  Aurora
//
//  Created by Alex Buzov on 2019-01-26.
//

import Foundation

internal typealias LightsTransformer = ([Light]) -> [(updatedLight: Light, update: Light.Update)]

extension Aurora {
    /// Updates lights from preset
    internal func lightsTransformer(preset: Scene) -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                var light = light
                let lightState = Light.State(
                    hue: preset.coloring.randomHue,
                    saturation: preset.coloring.randomSaturation,
                    brightness: preset.coloring.randomBrightness * (self?.brightness ?? 1.0),
                    isPowered: preset.effects.contains(.strobe) ? !(light.state?.isPowered ?? false) : true
                )
                let update = light.update(from: lightState, withTransitionTime: preset.input.transition)
                return (light, update)
            }
        }
    }

    /// Updates lights from preset with monocolor
    internal func lightsTransformer(preset: Scene, hue: Float, brightness: Float, saturation: Float) -> LightsTransformer {
        return { lights in
            lights.compactMap { [weak self] light in
                let saturation = min(preset.coloring.saturation.maximum, max(saturation, preset.coloring.saturation.minimum))
                let brightness = min(preset.coloring.brightness.maximum, max(brightness, preset.coloring.brightness.minimum))

                var light = light
                let lightState = Light.State(
                    hue: hue,
                    saturation: saturation,
                    brightness: brightness * (self?.brightness ?? 1.0),
                    isPowered: true
                )
                let update = light.update(from: lightState, withTransitionTime: preset.input.transition)
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
                        hue: nil,
                        saturation: 1.0,
                        brightness: 1.0 * (self?.brightness ?? 1.0),
                        isPowered: true
                    )
                } else {
                    lightState = Light.State(
                        hue: nil,
                        saturation: nil,
                        brightness: nil,
                        isPowered: false
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
                    hue: Float.random(in: 0...1),
                    saturation: Float.random(in: 0...1),
                    brightness: Float.random(in: 0...1) * (self?.brightness ?? 1.0),
                    isPowered: true
                )
                let update = light.update(from: lightState, withTransitionTime: Float.random(in: 0...5))
                return (light, update)
            }
        }
    }
}
