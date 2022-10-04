// swift-tools-version: 5.5

import PackageDescription

extension String {
    static let timber = "Timber"

    static func tests(for name: String) -> Self { name + "Tests" }
}

extension Target.Dependency {
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
    dependencies: [],
    targets: [
        .target(name: .timber),
        .testTarget(
            name: .tests(for: .timber),
            dependencies: [.timber]
        )
    ]
)
