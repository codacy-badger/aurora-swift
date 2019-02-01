@testable import Aurora
import XCTest

class LightSyncTests: XCTestCase {
    func testLightSync() {
        var lights: [Light] = []

        /// Sync new light
        let firstLight = Light(
            identifier: UUID(),
            name: "Light1",
            type: "simulated",
            state: Light.State(hue: 0.1, saturation: 0.2, brightness: 0.3, isPowered: true),
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            model: "v1"
        )

        XCTAssert(lights.sync(with: [firstLight]) == true)
        XCTAssert(lights.first == firstLight)

        /// Sync same light with chnages
        let updatedLight = Light(
            identifier: UUID(),
            name: "Light2",
            type: "simulated",
            state: Light.State(hue: 0.8, saturation: 0.9, brightness: 1.0, isPowered: false),
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            model: "v2"
        )

        XCTAssert(lights.sync(with: [updatedLight]) == true)
        XCTAssert(lights.count == 1)

        if let light = lights.first {
            XCTAssert(light.identifier == firstLight.identifier)
            XCTAssert(light.name == updatedLight.name)
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state != nil)
            XCTAssert(light.isReachable == true)
            XCTAssert(light.state == updatedLight.state)
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }

        /// Sync same light as unreachable without state
        let unreachableLight = Light(
            identifier: UUID(),
            name: "Light2",
            type: "simulated",
            state: nil,
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            model: "v2"
        )

        XCTAssert(lights.sync(with: [unreachableLight]) == true)
        XCTAssert(lights.count == 1)

        if let light = lights.first {
            XCTAssert(light.identifier == firstLight.identifier)
            XCTAssert(light.name == updatedLight.name)
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state == nil)
            XCTAssert(light.isReachable == false)
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }

        /// Sync same light as reachable with state
        let reconnectedLight = Light(
            identifier: UUID(),
            name: "Light",
            type: "simulated",
            state: Light.State(hue: 0.8, saturation: 0.9, brightness: 1.0, isPowered: false),
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            model: "v2"
        )

        XCTAssert(lights.sync(with: [reconnectedLight]) == true)
        XCTAssert(lights.count == 1)

        if let light = lights.first {
            XCTAssert(light.identifier == firstLight.identifier)
            XCTAssert(light.name == "Light")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state == Light.State(hue: 0.8, saturation: 0.9, brightness: 1.0, isPowered: false))
            XCTAssert(light.isReachable == true)
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }

        /// Sync same light as reachable with state
        let secondLight = Light(
            identifier: UUID(),
            name: "Another Light",
            type: "simulated",
            state: Light.State(hue: 0.8, saturation: 0.9, brightness: 1.0, isPowered: false),
            manufacturerIdentifier: "2",
            bridgeIdentifier: "DJKLHLJ22D",
            model: "v2"
        )

        XCTAssert(lights.sync(with: [secondLight]) == true)
        XCTAssert(lights.count == 2)

        if let light = lights.last {
            XCTAssert(light.identifier == secondLight.identifier)
            XCTAssert(light.name == "Another Light")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state == Light.State(hue: 0.8, saturation: 0.9, brightness: 1.0, isPowered: false))
            XCTAssert(light.isReachable == true)
            XCTAssert(light.manufacturerIdentifier == "2")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }
    }
}
