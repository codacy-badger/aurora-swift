// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Aurora",
    platforms: [
        .macOS(.v10_13), .iOS(.v12)
    ],
    products: [
        .library(name: "Aurora", type: .static, targets: ["Aurora"])
    ],
    targets: [
        .target(name: "Aurora"),
        .target(name: "Simulated", dependencies: ["Aurora"]),
        .testTarget(name: "AuroraTests", dependencies: ["Aurora", "Simulated"])
    ]
)
