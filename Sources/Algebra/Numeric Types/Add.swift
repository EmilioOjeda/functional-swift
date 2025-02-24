//
//  Add.swift
//  functional-swift
//

import Prelude

public struct Add<Value: Addition> {
    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension Add: Sendable where Value: Sendable {}

extension Add: Equatable where Value: Equatable {}

extension Add: Hashable where Value: Hashable {}

// MARK: - Add: ExpressibleByIntegerLiteral

extension Add: ExpressibleByIntegerLiteral where IntegerLiteralType == Value {
    public init(integerLiteral value: Value) {
        self.value = value
    }
}

// MARK: - Add: ExpressibleByFloatLiteral

extension Add: ExpressibleByFloatLiteral where FloatLiteralType == Value {
    public init(floatLiteral value: Value) {
        self.value = value
    }
}

// MARK: - Add: Semigroup

extension Add: Semigroup {
    public static func <> (lhs: Add<Value>, rhs: Add<Value>) -> Add<Value> {
        Add(lhs.value + rhs.value)
    }
}

// MARK: - Add: Monoid

extension Add: Monoid {
    public static var empty: Add<Value> {
        Add(Value.zero)
    }
}
