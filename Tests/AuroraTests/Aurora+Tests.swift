import XCTest
@testable import Aurora

class AuroraTests: XCTestCase {

    func testAuroraBehaviour() {
        let jsonFileContents = """
        {
            "mode": "simplex",
            "lights": [
                {
                    "identifier": "147936b6-f17f-4295-8ee1-485fa0d46599",
                    "name": "Light",
                    "type": "simulated",
                    "manufacturerIdentifier": "1",
                    "bridgeIdentifier": "FJKLWJDL22",
                    "model": "v1"
                }
            ],
            "activeLightIdentifiers": [
                "147936b6-f17f-4295-8ee1-485fa0d46599"
            ],
            "scenes": [
                {
                    "identifier": "6e0dc91a-9090-468e-b193-91dddb1f616b",
                    "name": "Milky Way",
                    "lights": [],
                    "input": { "mode": "time", "interval": 1.0, "transition": 1.0 },
                    "output": { "mode": "none", "track": null },
                    "coloring": { "mode": "spectrum", "hue": 0.5, "range": "0.0...1.0", "spectrum": 127, "saturation": "0.0...1.0", "brightness": "0.0...1.0" },
                    "effects": 0
                }
            ],
            "connectors": ["simulated"]
        }
        """

        guard let data = jsonFileContents.data(using: .utf8) else {
            XCTFail("Unreadable data")
            return
        }

        guard let aurora = try? JSONDecoder().decode(Aurora.self, from: data) else {
            XCTFail("Failed to decode Aurora")
            return
        }

        XCTAssert(aurora.mode == .simplex)
        XCTAssert(aurora.lights.count == 1)
        XCTAssert(aurora.activeLightIdentifiers.count == 1)
        XCTAssert(aurora.scenes.count == 1)
        XCTAssert(aurora.activeSceneIdentifiers.isEmpty)
        XCTAssert(aurora.connectors.count == 1)
        XCTAssert(aurora.attachedConnectors.isEmpty)

        let constructor = SimulatedConstructor()
        /// Add Constructor
        aurora.constructor = constructor

        aurora.attachConnectors()

        XCTAssert(aurora.connectors.count == 1)
        XCTAssert(aurora.attachedConnectors.count == 1)
    }

}
