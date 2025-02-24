//
//  Or.swift
//  functional-swift
//

import Prelude

public struct Or: Equatable, Hashable, Sendable {
    public let value: Bool

    public init(_ value: Bool) {
        self.value = value
    }
}

// MARK: - Or: ExpressibleByBooleanLiteral

extension Or: ExpressibleByBooleanLiteral {
    public init(booleanLiteral bool: Bool) {
        self.value = bool
    }
}

// MARK: - Or: Semigroup

extension Or: Semigroup {
    public static func <> (lhs: Or, rhs: Or) -> Or {
        Or(lhs.value || rhs.value)
    }
}

// MARK: - Or: Monoid

extension Or: Monoid {
    public static let empty: Or = false
}
