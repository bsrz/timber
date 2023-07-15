// swift-tools-version: 5.8

import PackageDescription

extension String {
    static let timber = "Timber"

    var tests: Self { self + "Tests" }
}

extension Target.Dependency {
    static let algos: Self = .product(name: "Algorithms", package: "swift-algorithms")
    static let timber: Self = .init(stringLiteral: .timber)
}

let package = Package(
    name: .timber,
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(
            name: .timber,
            targets: [.timber]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: .init(1, 0, 0))
    ],
    targets: [
        .target(name: .timber, dependencies: [.algos]),
        .testTarget(
            name: .timber.tests,
            dependencies: [.timber]
        )
    ]
)
