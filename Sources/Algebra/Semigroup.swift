//
//  Semigroup.swift
//  functional-swift
//

import Prelude

// MARK: - Semigroup

public protocol Semigroup {
    static func <> (_ lhs: Self, _ rhs: Self) -> Self
}

public func concat<S: Semigroup>(_ value: S, _ values: [S]) -> S {
    values.reduce(value, <>)
}

// MARK: - String: Semigroup

extension String: Semigroup {
    public static func <> (lhs: String, rhs: String) -> String {
        lhs + rhs
    }
}

// MARK: - Array: Semigroup

extension Array: Semigroup {
    public static func <> (lhs: [Element], rhs: [Element]) -> [Element] {
        lhs + rhs
    }
}

// MARK: - Optional: Semigroup

extension Optional: Semigroup where Wrapped: Semigroup {
    public static func <> (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Optional<Wrapped> {
        switch (lhs, rhs) {
        case (.none, _):
            rhs
        case (_, .none):
            lhs
        case let (.some(lhs), .some(rhs)):
            .some(lhs <> rhs)
        }
    }
}
