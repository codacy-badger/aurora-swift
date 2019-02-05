@testable import Aurora
import XCTest

class AuroraInputOutputTests: XCTestCase {
    private let defaultScenes: [Scene] = [
        /// Static Scenes
        Scene(name: "Scene1"),
        Scene(name: "Scene2"),
        Scene(name: "Scene3"),
        /// Time Input Scenes
        Scene(name: "TimeInputScene1", input: Input.Settings(mode: .time)),
        Scene(name: "TimeInputScene2", input: Input.Settings(mode: .time)),
        Scene(name: "TimeInputScene3", input: Input.Settings(mode: .time), output: Output.Settings(mode: .audio, track: "simulatedTrack1")),
        /// Audio Input Scenes
        Scene(name: "AudioInputScene1", input: Input.Settings(mode: .audio)),
        Scene(name: "AudioInputScene2", input: Input.Settings(mode: .audio)),
        Scene(name: "AudioInputScene3", input: Input.Settings(mode: .audio), output: Output.Settings(mode: .audio, track: "simulatedTrack2")),
        /// Video Input Scenes
        Scene(name: "VideoInputScene1", input: Input.Settings(mode: .video)),
        Scene(name: "VideoInputScene2", input: Input.Settings(mode: .video)),
        Scene(name: "VideoInputScene3", input: Input.Settings(mode: .video), output: Output.Settings(mode: .audio, track: "simulatedTrack3"))
    ]

    func testAuroraInputsOutputs() {
        verifyInputsOutputsTests(forMode: .simplex, randomizations: 100)
        verifyInputsOutputsTests(forMode: .multiplex, randomizations: 300)
    }

    func verifyInputsOutputsTests(forMode mode: Aurora.Mode, randomizations count: Int) {
        /// Setup aurora with simulated inputs,outputs
        let aurora = Aurora(mode: mode, scenes: defaultScenes)
        let constructor = SimulatedConstructor()
        aurora.constructor = constructor

        (0...count).forEach { step in
            print("Step:", step)
            guard let scene = defaultScenes.randomElement() else {
                XCTFail("Empty Identifiers array")
                return
            }

            aurora.toggle(sceneWithIdentifier: scene.identifier)

            /// Test Inputs
            let timeInputScenes = aurora.activeScenes.filter { $0.input.mode == .time }

            if timeInputScenes.isEmpty {
                XCTAssert(aurora.input.time == nil)
            } else {
                switch aurora.mode {
                case .simplex:
                    XCTAssert(timeInputScenes.count == 1)
                    XCTAssert(aurora.input.time?.loopVariations.count == 1)
                case .multiplex:
                    XCTAssert(timeInputScenes.count == aurora.input.time?.loopVariations.count)
                }
            }

            XCTAssert(aurora.activeScenes.filter { $0.input.mode == .audio }.isEmpty == (aurora.input.audio == nil) )
            XCTAssert(aurora.activeScenes.filter { $0.input.mode == .video }.isEmpty == (aurora.input.video == nil) )

            /// Test outputs
            if aurora.mode == .simplex {
                XCTAssert(aurora.activeScenes.filter { $0.output.mode == .audio }.isEmpty == (aurora.output.audio == nil) )

                /// Switch input to a new random
                if .random(), let randomInput = Input.Mode.allCases.randomElement() {
                    aurora.set(inputMode: randomInput, forSceneWithIdentifier: scene.identifier)
                }
            }
        }
    }
}
