import Aurora
import XCTest

class SceneTests: XCTestCase {
    func testSceneInit() {
        let scene = Scene(
            name: "Scene",
            identifier: UUID(),
            lights: [UUID(), UUID()],
            input: Inputs.Settings(mode: .time, interval: 1.0, transition: 1.0),
            output: Outputs.Settings(mode: .none, track: nil),
            coloring: Coloring(
                mode: .spectrum,
                hue: 0.5,
                range: .unitInterval,
                spectrum: .allColors,
                saturation: 0.0...0.5,
                brightness: 0.5...1.0
            ),
            effects: [],
            context: "ea69bb74-a7c9-428f-b48b-44168c70db5a"
        )

        XCTAssert(scene.name == "Scene")
    }
}
