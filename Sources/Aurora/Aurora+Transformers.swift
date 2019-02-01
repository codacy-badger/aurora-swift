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
            return lights.compactMap { [weak self] light in
                var light = light
                let update = light.update(
                    with: Light.State.Update(
                        hue: preset.coloring.randomHue,
                        saturation: preset.coloring.randomSaturation,
                        brightness: preset.coloring.randomBrightness * (self?.brightness ?? 1.0),
                        isPowered: preset.effects.contains(.strobe) ? !(light.state?.isPowered ?? false) : true,
                        transitionTime: preset.input.transition
                    )
                )

                if let update = update {
                    return (light, update)
                } else {
                    return nil
                }
            }
        }
    }

    /// Updates lights from preset with monocolor
    internal func lightsTransformer(preset: Scene, hue: Float, brightness: Float, saturation: Float) -> LightsTransformer {
        return { lights in
            return lights.compactMap { [weak self] light in
                let saturation = min(preset.coloring.saturation.maximum, max(saturation, preset.coloring.saturation.minimum))
                let brightness = min(preset.coloring.brightness.maximum, max(brightness, preset.coloring.brightness.minimum))

                var light = light
                let update = light.update(
                    with: Light.State.Update(
                        hue: hue,
                        saturation: saturation,
                        brightness: brightness * (self?.brightness ?? 1.0),
                        isPowered: true,
                        transitionTime: preset.input.transition
                    )
                )

                if let update = update {
                    return (light, update)
                } else {
                    return nil
                }
            }
        }
    }

    internal func lightsTransformer(power: Bool) -> LightsTransformer {
        return { lights in
            return lights.compactMap { [weak self] light in

                var light = light

                let powerOnChanges = Light.State.Update(
                    saturation: 1.0,
                    brightness: 1.0 * (self?.brightness ?? 1.0),
                    isPowered: true,
                    transitionTime: 1.0
                )

                let powerOffChanges = Light.State.Update(
                    isPowered: true,
                    transitionTime: 1.0
                )

                let update = light.update(with: power ? powerOnChanges : powerOffChanges)

                if let update = update {
                    return (light, update)
                } else {
                    return nil
                }
            }
        }
    }

    internal func randomLightsTransformer() -> LightsTransformer {
        return { lights in
            return lights.compactMap { [weak self] light in

                var light = light
                let update = light.update(
                    with: Light.State.Update(
                        hue: Float.random(in: 0...1),
                        saturation: Float.random(in: 0...1),
                        brightness: Float.random(in: 0...1) * (self?.brightness ?? 1.0),
                        isPowered: true,
                        transitionTime: Float.random(in: 0...5)
                    )
                )

                if let update = update {
                    return (light, update)
                } else {
                    return nil
                }
            }
        }
    }

}
