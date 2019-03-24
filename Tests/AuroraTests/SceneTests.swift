import Aurora
import XCTest

class SceneTests: XCTestCase {
    func testSceneInit() {
        let scene = Scene(
            name: "Scene",
            identifier: UUID(),
            lights: [UUID(), UUID()],
            input: .time(.interval(1.0)),
            output: .audio(.track("123")),
            hue: 0.5,
            saturation: .range(0.0...0.5),
            brightness: .range(0.5...1.0),
            transition: 0.5,
            effects: [],
            context: "ea69bb74-a7c9-428f-b48b-44168c70db5a"
        )

        XCTAssert(scene.name == "Scene")
        XCTAssert(scene.hue == .constant(0.5))
    }
}
