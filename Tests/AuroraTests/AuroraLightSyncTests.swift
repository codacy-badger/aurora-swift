import Aurora
import XCTest

class AuroraLightSyncTests: XCTestCase {
    func testLightsSyncFromAttributes() {
        let aurora = Aurora(mode: .simplex)
        XCTAssert(aurora.lights.isEmpty)

        /// Sync first light with minimum attributes and without a state
        let light1Attributes1: [String: Any] = [
            Attribute.manufacturerIdentifier.rawValue: "1",
            Attribute.name.rawValue: "Light 1",
            Attribute.type.rawValue: "simulated"
        ]

        aurora.sync(lights: [light1Attributes1])

        XCTAssert(aurora.lights.count == 1)

        if let light = aurora.lights.first {
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.name == "Light 1")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.bridgeIdentifier == nil)
            XCTAssert(light.model == nil)
            XCTAssert(light.state == nil)
            XCTAssert(light.isReachable == false)
        } else {
            XCTFail("No lights is synced")
        }

        ///Sync light all attributes with state

        let light1Attributes2: [String: Any] = [
            Attribute.manufacturerIdentifier.rawValue: "1",
            Attribute.name.rawValue: "Light 2",
            Attribute.type.rawValue: "simulated",
            Attribute.model.rawValue: "v1",
            Attribute.power.rawValue: true,
            Attribute.hue.rawValue: Float(0.6),
            Attribute.saturation.rawValue: Float(0.8),
            Attribute.brightness.rawValue: Float(1.0)
        ]

        aurora.sync(lights: [light1Attributes2])

        XCTAssert(aurora.lights.count == 1)

        if let light = aurora.lights.first {
            XCTAssert(light.manufacturerIdentifier == "1")
            XCTAssert(light.name == "Light 2")
            XCTAssert(light.type == "simulated")
            XCTAssert(light.model == "v1")
            XCTAssert(light.isReachable == true)
            XCTAssert(light.state == Light.State(isPowered: true, hue: 0.6, saturation: 0.8, brightness: 1.0))
        } else {
            XCTFail("No lights is synced")
        }
    }
}
