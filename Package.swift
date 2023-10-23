// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "ViewRouting",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "ViewRouting", targets: ["ViewRouting"])
    ],
    targets: [
        .target(name: "ViewRouting"),
        .testTarget(name: "ViewRoutingTests", dependencies: ["ViewRouting"])
    ]
)
