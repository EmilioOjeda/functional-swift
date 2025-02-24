//
//  Min.swift
//  functional-swift
//

import Prelude

public struct Min<Value: ComparableToTop> {
    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension Min: Sendable where Value: Sendable {}

extension Min: Equatable where Value: Equatable {}

extension Min: Hashable where Value: Hashable {}

// MARK: - Min: ExpressibleByIntegerLiteral

extension Min: ExpressibleByIntegerLiteral where IntegerLiteralType == Value {
    public init(integerLiteral value: Value) {
        self.value = value
    }
}

// MARK: - Min: Semigroup

extension Min: Semigroup {
    public static func <> (lhs: Min<Value>, rhs: Min<Value>) -> Min<Value> {
        Min(min(lhs.value, rhs.value))
    }
}

// MARK: - Min: Monoid

extension Min: Monoid {
    public static var empty: Min<Value> {
        Min(Value.max)
    }
}
