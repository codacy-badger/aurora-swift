@testable import Aurora
import XCTest

class LightUnreachableTests: XCTestCase {
    func testForceUnrechable() {
        var lights = [
            Light(
                identifier: UUID(),
                name: "Light1",
                type: "simulated",
                state: Light.State(hue: 0.2, saturation: 0.3, brightness: 0.4, isPowered: true),
                manufacturerIdentifier: "1"
            ),
            Light(
                identifier: UUID(),
                name: "Light2",
                type: "simulated",
                state: Light.State(hue: 0.2, saturation: 0.3, brightness: 0.4, isPowered: true),
                manufacturerIdentifier: "2"
            ),
            Light(
                identifier: UUID(),
                name: "Light3",
                type: "unknown",
                state: Light.State(hue: 0.2, saturation: 0.3, brightness: 0.4, isPowered: true),
                manufacturerIdentifier: "1"
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
