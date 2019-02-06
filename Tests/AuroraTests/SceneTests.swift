import Aurora
import XCTest

class SceneTests: XCTestCase {
    func testSceneInit() {
        let scene = Scene(
            name: "Scene",
            identifier: UUID(),
            lights: [UUID(), UUID()],
            input: Input.Settings(mode: .time, interval: 1.0, transition: 1.0),
            output: Output.Settings(mode: .none, track: nil),
            coloring: Coloring(
                mode: .spectrum,
                hue: 0.5,
                range: .unitInterval,
                spectrum: .allColors,
                saturation: 0.0...0.5,
                brightness: 0.5...1.0
            ),
            effects: []
        )

        XCTAssert(scene.name == "Scene")
    }
}
