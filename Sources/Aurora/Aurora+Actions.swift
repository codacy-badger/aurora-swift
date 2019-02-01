import Foundation

extension Aurora {

    public func powerOnActiveLights() {
        guard mode == .simplex else {
            return
        }
        deactivateScenes()
        update(lights: self.activeLights.reachable, with: lightsTransformer(power: true))
    }

    public func powerOffActiveLights() {
        guard mode == .simplex else {
            return
        }
        deactivateScenes()
        update(lights: self.activeLights.reachable, with: lightsTransformer(power: false))
    }

    public func randomizeActiveLights() {
        guard mode == .simplex else {
            return
        }
        deactivateScenes()
        update(lights: self.activeLights.reachable, with: randomLightsTransformer())
    }
}
