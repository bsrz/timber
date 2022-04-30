// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Timber",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Timber",
            targets: ["Timber"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Timber",
            dependencies: []
        ),
        .testTarget(
            name: "TimberTests",
            dependencies: ["Timber"]
        ),
    ]
)
