@testable import Aurora
import Simulated
import XCTest

class AuroraInputOutputTests: XCTestCase {
    private let defaultScenes: [Scene] = [
        /// Static Scenes
        Scene(name: "Scene1"),
        Scene(name: "Scene2"),
        Scene(name: "Scene3"),
        /// Time Input Scenes
        Scene(name: "TimeInputScene1", input: .time(.interval(1.0))),
        Scene(name: "TimeInputScene2", input: .time(.interval(1.0))),
        Scene(name: "TimeInputScene3", input: .time(.interval(1.0)), output: .audio(.track("simulatedTrack1"))),
        /// Audio Input Scenes
        Scene(name: "AudioInputScene1", input: .audio(.source())),
        Scene(name: "AudioInputScene2", input: .audio(.source())),
        Scene(name: "AudioInputScene3", input: .audio(.source()), output: .audio(.track("simulatedTrack2"))),
        /// Video Input Scenes
        Scene(name: "VideoInputScene1", input: .video(.source())),
        Scene(name: "VideoInputScene2", input: .video(.source())),
        Scene(name: "VideoInputScene3", input:.video(.source()), output: .audio(.track("simulatedTrack3")))
    ]

    func testAuroraInputsOutputs() {
        verifyInputsOutputsTests(forMode: .simplex, randomizations: 1_000)
        verifyInputsOutputsTests(forMode: .multiplex, randomizations: 1_000)
    }

    func verifyInputsOutputsTests(forMode mode: Aurora.Mode, randomizations count: Int) {
        /// Setup aurora with simulated inputs,outputs
        let aurora = Aurora(mode: mode, scenes: defaultScenes)
        aurora.connectorsGenerator = { SimulatedConnector(type: $0) }
        aurora.inputGenerator = Input.Generator(time: { DeviceTimeInput() }, audio: { SimulatedAudioInput() }, video: { SimulatedVideoInput() })
        aurora.outputGenerator = Output.Generator { SimulatedAudioOutput() }

        (0...count).forEach { step in
            print("Step:", step)
            guard let scene = defaultScenes.randomElement() else {
                XCTFail("Empty Identifiers array")
                return
            }

            aurora.toggle(sceneWithIdentifier: scene.identifier)

            /// Test Inputs
            let timeInputScenes = aurora.activeScenes.timeInputScenes

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

            XCTAssert(aurora.activeScenes.audioInputScenes.isEmpty == (aurora.input.audio == nil) )
            XCTAssert(aurora.activeScenes.videoInputScenes.isEmpty == (aurora.input.video == nil) )

            /// Test outputs
            if aurora.mode == .simplex {
                XCTAssert(aurora.activeScenes.compactMap { $0.output }.filter {
                    if case Output.Settings.audio(_) = $0 { return true } else { return false }
                }.isEmpty == (aurora.output.audio == nil) )

                /// Switch input to a new random
                if .random(), let randomInput = Input.Settings.allCases.randomElement() {
                    aurora.set(input: randomInput, forSceneWithIdentifier: scene.identifier)
                }
            }
        }
    }
}
