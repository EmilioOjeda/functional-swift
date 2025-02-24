// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "functional-swift",
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
    targets: [
        // -> Prelude
        .target(
            name: "Prelude"
        ),
        .testTarget(
            name: "PreludeTests",
            dependencies: [.prelude]
        ),
        // -> Algebra
        .target(
            name: "Algebra",
            dependencies: [.prelude]
        ),
        .testTarget(
            name: "AlgebraTests",
            dependencies: [.prelude, .algebra]
        ),
        // -> Either
        .target(
            name: "Either",
            dependencies: [.prelude]
        ),
        .testTarget(
            name: "EitherTests",
            dependencies: [.prelude, .either]
        ),
        // -> Optional
        .target(
            name: "Optional",
            dependencies: [.prelude, .either]
        ),
        .testTarget(
            name: "OptionalTests",
            dependencies: [.prelude, .either, .optional]
        ),
        // -> Validated
        .target(
            name: "Validated",
            dependencies: [.prelude, .algebra]
        ),
        .testTarget(
            name: "ValidatedTests",
            dependencies: [.prelude, .algebra, .validated]
        )
    ]
)

// MARK: - target dependencies

private extension Target.Dependency {
    // --
    static var prelude: Self { .target(name: "Prelude") }
    // ----
    static var algebra: Self { .target(name: "Algebra") }
    static var either: Self { .target(name: "Either") }
    // ------
    static var optional: Self { .target(name: "Optional") }
    static var validated: Self { .target(name: "Validated") }
}
