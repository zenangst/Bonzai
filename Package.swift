// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Bonzai",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Bonzai", targets: ["Bonzai"]),
    ],
    targets: [
        .target(
            name: "Bonzai",
            dependencies: [ ])
    ]
)

