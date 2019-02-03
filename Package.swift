// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Aurora",
    products: [
        .library(name: "Aurora", targets: ["Aurora"])
    ],
    targets: [
        .target(name: "Aurora"),
        .testTarget(name: "AuroraTests", dependencies: ["Aurora"])
    ]
)
