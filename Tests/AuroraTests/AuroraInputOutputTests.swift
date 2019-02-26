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
        Scene(name: "TimeInputScene1", input: Inputs.Settings(mode: .time)),
        Scene(name: "TimeInputScene2", input: Inputs.Settings(mode: .time)),
        Scene(name: "TimeInputScene3", input: Inputs.Settings(mode: .time), output: Outputs.Settings(mode: .audio, track: "simulatedTrack1")),
        /// Audio Input Scenes
        Scene(name: "AudioInputScene1", input: Inputs.Settings(mode: .audio)),
        Scene(name: "AudioInputScene2", input: Inputs.Settings(mode: .audio)),
        Scene(name: "AudioInputScene3", input: Inputs.Settings(mode: .audio), output: Outputs.Settings(mode: .audio, track: "simulatedTrack2")),
        /// Video Input Scenes
        Scene(name: "VideoInputScene1", input: Inputs.Settings(mode: .video)),
        Scene(name: "VideoInputScene2", input: Inputs.Settings(mode: .video)),
        Scene(name: "VideoInputScene3", input: Inputs.Settings(mode: .video), output: Outputs.Settings(mode: .audio, track: "simulatedTrack3"))
    ]

    func testAuroraInputsOutputs() {
        verifyInputsOutputsTests(forMode: .simplex, randomizations: 1_000)
        verifyInputsOutputsTests(forMode: .multiplex, randomizations: 1_000)
    }

    func verifyInputsOutputsTests(forMode mode: Aurora.Mode, randomizations count: Int) {
        /// Setup aurora with simulated inputs,outputs
        let aurora = Aurora(mode: mode, scenes: defaultScenes)
        aurora.connectorsGenerator = { SimulatedConnector(type: $0) }
        aurora.inputsGenerator = Inputs.Generator(time: { DeviceTimeInput() }, audio: { SimulatedAudioInput() }, video: { SimulatedVideoInput() })
        aurora.outputsGenerator = Outputs.Generator { SimulatedAudioOutput() }

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

            /// Test outputsd
            if aurora.mode == .simplex {
                XCTAssert(aurora.activeScenes.filter { $0.output.mode == .audio }.isEmpty == (aurora.output.audio == nil) )

                /// Switch input to a new random
                if .random(), let randomInput = Inputs.Mode.allCases.randomElement() {
                    aurora.set(inputMode: randomInput, forSceneWithIdentifier: scene.identifier)
                }
            }
        }
    }
}
