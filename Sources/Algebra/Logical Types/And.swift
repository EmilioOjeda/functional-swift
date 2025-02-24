//
//  And.swift
//  functional-swift
//

import Prelude

public struct And: Equatable, Hashable, Sendable {
    public let value: Bool

    public init(_ value: Bool) {
        self.value = value
    }
}

// MARK: - And: ExpressibleByBooleanLiteral

extension And: ExpressibleByBooleanLiteral {
    public init(booleanLiteral bool: Bool) {
        self.value = bool
    }
}

// MARK: - And: Semigroup

extension And: Semigroup {
    public static func <> (lhs: And, rhs: And) -> And {
        And(lhs.value && rhs.value)
    }
}

// MARK: - And: Monoid

extension And: Monoid {
    public static let empty: And = true
}
