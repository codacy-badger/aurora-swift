import XCTest

extension AuroraTests {
    static let __allTests = [
        ("testAuroraBehaviour", testAuroraBehaviour),
    ]
}

extension LightSyncTests {
    static let __allTests = [
        ("testLightSync", testLightSync),
    ]
}

extension LightUnreachableTests {
    static let __allTests = [
        ("testForceUnrechable", testForceUnrechable),
    ]
}

extension SceneTests {
    static let __allTests = [
        ("testSceneInit", testSceneInit),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AuroraTests.__allTests),
        testCase(LightSyncTests.__allTests),
        testCase(LightUnreachableTests.__allTests),
        testCase(SceneTests.__allTests),
    ]
}
#endif
