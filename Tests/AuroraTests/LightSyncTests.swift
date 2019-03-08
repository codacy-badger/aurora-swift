@testable import Aurora
import XCTest

class LightSyncTests: XCTestCase {
    func testLightSync() {
        var lights: [Light] = []

        /// Sync new light
        let firstLight = Light(
            name: "Light1",
            type: "simulated",
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            state: Light.State(isPowered: true, hue: 0.1, saturation: 0.2, brightness: 0.3),
            model: "v1"
        )

        let result = lights.sync(with: [firstLight])
        XCTAssert(result.count == 1)
        XCTAssert(result.first?.0 == firstLight.identifier)
        XCTAssert(result.first?.1 == .newLight)
        XCTAssert(lights.first == firstLight)

        /// Sync same light with chnages
        let updatedLight = Light(
            name: "Light2",
            type: "simulated",
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            state: Light.State(isPowered: false, hue: 0.8, saturation: 0.9, brightness: 1.0),
            model: "v2"
        )

        let result2 = lights.sync(with: [updatedLight])
        XCTAssert(result2.count == 1)
        XCTAssert(result2.first?.0 == firstLight.identifier)
        XCTAssert(result2.first?.1 == [.updatedName, .updatedColor, .updatedModel])
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
            name: "Light2",
            type: "simulated",
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            state: nil,
            model: "v2"
        )

        let result3 = lights.sync(with: [unreachableLight])
        XCTAssert(result3.count == 1)
        XCTAssert(result3.first?.0 == firstLight.identifier)
        XCTAssert(result3.first?.1 == [.updatedReachability])
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
            name: "Light",
            type: "simulated",
            manufacturerIdentifier: "1",
            bridgeIdentifier: "DJKLHLJ22D",
            state: Light.State(isPowered: false, hue: 0.8, saturation: 0.9, brightness: 1.0),
            model: "v2"
        )

        let result4 = lights.sync(with: [reconnectedLight])
        XCTAssert(result4.count == 1)
        XCTAssert(result4.first?.0 == firstLight.identifier)
        XCTAssert(result4.first?.1 == [.updatedReachability, .updatedColor, .updatedName])
        XCTAssert(lights.count == 1)

        if let light = lights.first {
            XCTAssert(light.identifier == firstLight.identifier)
            XCTAssert(light.name == "Light")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state == Light.State(isPowered: false, hue: 0.8, saturation: 0.9, brightness: 1.0))
            XCTAssert(light.isReachable == true)
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }

        /// Sync same light as reachable with state
        let secondLight = Light(
            name: "Another Light",
            type: "simulated",
            manufacturerIdentifier: "2",
            bridgeIdentifier: "DJKLHLJ22D",
            state: Light.State(isPowered: false, hue: 0.8, saturation: 0.9, brightness: 1.0),
            model: "v2"
        )

        let result5 = lights.sync(with: [secondLight])
        XCTAssert(result5.count == 1)
        XCTAssert(result5.first?.0 == secondLight.identifier)
        XCTAssert(result5.first?.1 == [.newLight])
        XCTAssert(lights.count == 2)

        if let light = lights.last {
            XCTAssert(light.identifier == secondLight.identifier)
            XCTAssert(light.name == "Another Light")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.state == Light.State(isPowered: false, hue: 0.8, saturation: 0.9, brightness: 1.0))
            XCTAssert(light.isReachable == true)
            XCTAssert(light.manufacturerIdentifier == "2")
            XCTAssert(light.bridgeIdentifier == "DJKLHLJ22D")
            XCTAssert(light.model == "v2")
        } else {
            XCTFail("Could not find a light")
        }
    }
}
