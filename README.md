# functional-swift

A collection of libraries/utilities that bring functional programming types, patterns and concepts to Swift.

## Overview

**functional-swift** is a Swift Package Manager project that offers a suite of libraries designed to help you work with functional programming paradigms in Swift. The package is organized into several focused modules:

+ **Prelude** 
    - Provides the foundational functions and utilities needed across the other modules.
+ **Algebra**
    - Implements common algebraic structures and operations (like semigroups, monoids, etc.) for more abstract and composable code.
+ **Either**
    - Introduces the `Either` type, which is useful for expressing computations that may have 2 possible values; either one value or another.
    - It may also be helpful for representing computations that might fail, providing a robust alternative to traditional error handling.
+ **Optional**
    - Extends the capabilities of Swift's built-in `Optional` type with additional "functional" utilities.
+ **Validated**
    - Offers tools for data validation, enabling safe composition and error accumulation when processing data.

## Installation

Add **functional-swift** as a dependency in your `Package.swift`:

```swift
...
dependencies: [
    .package(url: "https://github.com/EmilioOjeda/functional-swift.git", from: "0.0.0")
]
...
```

## Documentation

+ [**Prelude**](Docs/PRELUDE.md)
+ [**Algebra**](Docs/ALGEBRA.md)
+ [**Either**](Docs/EITHER.md)
+ [**Optional**](Docs/OPTIONAL.md)
+ [**Validated**](Docs/VALIDATED.md)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
