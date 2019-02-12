// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Aurora",
    products: [
        .library(name: "Aurora", type: .static, targets: ["Aurora"])
    ],
    targets: [
        .target(name: "Aurora"),
        .target(name: "Simulated", dependencies: ["Aurora"]),
        .testTarget(name: "AuroraTests", dependencies: ["Aurora", "Simulated"])
    ]
)
