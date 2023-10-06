// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ZenViewKit",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "ZenViewKit", targets: ["ZenViewKit"]),
    ],
    targets: [
        .target(
            name: "ZenViewKit",
            dependencies: [ ])
    ]
)

