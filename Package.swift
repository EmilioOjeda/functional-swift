// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "functional-swift",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .visionOS(.v1),
        .driverKit(.v22)
    ],
    products: [
        .library(
            name: "Prelude",
            targets: ["Prelude"]
        ),
        .library(
            name: "Algebra",
            targets: ["Algebra"]
        ),
        .library(
            name: "Either",
            targets: ["Either"]
        ),
        .library(
            name: "Optional",
            targets: ["Optional"]
        ),
        .library(
            name: "Validated",
            targets: ["Validated"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            from: "0.58.2"
        )
    ],
    targets: [
        // -> Prelude
        .target(
            name: "Prelude",
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "PreludeTests",
            dependencies: [.prelude],
            plugins: [.swiftlint]
        ),
        // -> Algebra
        .target(
            name: "Algebra",
            dependencies: [.prelude],
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "AlgebraTests",
            dependencies: [.prelude, .algebra],
            plugins: [.swiftlint]
        ),
        // -> Either
        .target(
            name: "Either",
            dependencies: [.prelude],
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "EitherTests",
            dependencies: [.prelude, .either],
            plugins: [.swiftlint]
        ),
        // -> Optional
        .target(
            name: "Optional",
            dependencies: [.prelude, .either],
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "OptionalTests",
            dependencies: [.prelude, .either, .optional],
            plugins: [.swiftlint]
        ),
        // -> Validated
        .target(
            name: "Validated",
            dependencies: [.prelude, .algebra],
            plugins: [.swiftlint]
        ),
        .testTarget(
            name: "ValidatedTests",
            dependencies: [.prelude, .algebra, .validated],
            plugins: [.swiftlint]
        )
    ]
)

// MARK: - target dependencies

private extension Target.Dependency {
    // - level 0
    static var prelude: Self { .target(name: "Prelude") }
    // - level 1
    static var algebra: Self { .target(name: "Algebra") }
    static var either: Self { .target(name: "Either") }
    // - level 2
    static var optional: Self { .target(name: "Optional") }
    static var validated: Self { .target(name: "Validated") }
}

// MARK: - target plug-ins

private extension Target.PluginUsage {
    static var swiftlint: Self {
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
    }
}
