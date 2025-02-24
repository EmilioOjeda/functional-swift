//
//  Max.swift
//  functional-swift
//

import Prelude

public struct Max<Value: ComparableToBottom> {
    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension Max: Sendable where Value: Sendable {}

extension Max: Equatable where Value: Equatable {}

extension Max: Hashable where Value: Hashable {}

// MARK: - Max: ExpressibleByIntegerLiteral

extension Max: ExpressibleByIntegerLiteral where IntegerLiteralType == Value {
    public init(integerLiteral value: Value) {
        self.value = value
    }
}

// MARK: - Max: Semigroup

extension Max: Semigroup {
    public static func <> (lhs: Max<Value>, rhs: Max<Value>) -> Max<Value> {
        Max(max(lhs.value, rhs.value))
    }
}

// MARK: - Max: Monoid

extension Max: Monoid {
    public static var empty: Max<Value> {
        Max(Value.min)
    }
}
