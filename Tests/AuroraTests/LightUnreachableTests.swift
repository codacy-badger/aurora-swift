@testable import Aurora
import XCTest

class LightUnreachableTests: XCTestCase {
    func testForceUnrechable() {
        var lights = [
            Light(
                name: "Light1",
                type: "simulated",
                manufacturerIdentifier: "1",
                state: Light.State(isPowered: true, hue: 0.2, saturation: 0.3, brightness: 0.4)
            ),
            Light(
                name: "Light2",
                type: "simulated",
                manufacturerIdentifier: "2",
                state: Light.State(isPowered: true, hue: 0.2, saturation: 0.3, brightness: 0.4)
            ),
            Light(
                name: "Light3",
                type: "unknown",
                manufacturerIdentifier: "1",
                state: Light.State(isPowered: true, hue: 0.2, saturation: 0.3, brightness: 0.4)
            )
        ]

        XCTAssert(lights.count == 3)
        XCTAssert(lights.allSatisfy { $0.isReachable })

        lights = lights.forcedUnreachable(forType: "simulated")

        XCTAssert(lights.count == 3)
        XCTAssert(lights.reachable.count == 1)

        lights = lights.forcedUnrechable

        XCTAssert(lights.count == 3)
        XCTAssert(lights.reachable.isEmpty)
    }
}
