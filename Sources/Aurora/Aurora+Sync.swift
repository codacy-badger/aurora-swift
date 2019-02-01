import Foundation

extension Aurora {
    func sync(lights: [Light]) {
        /// Sync lights
        if self.lights.sync(with: lights) {
            /// Notify delegate if necessary
            delegates.forEach { $0.didUpdateLights() }
        }
    }

    func sync(event: Event) {
        print(event)
        delegates.forEach { $0.didReceive(event: event) }
    }
}
