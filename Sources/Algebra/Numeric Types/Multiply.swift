//
//  Multiply.swift
//  functional-swift
//

import Prelude

public struct Multiply<Value: Multiplication> {
    public let value: Value

    public init(_ value: Value) {
        self.value = value
    }
}

extension Multiply: Sendable where Value: Sendable {}

extension Multiply: Equatable where Value: Equatable {}

extension Multiply: Hashable where Value: Hashable {}

// MARK: - Multiply: ExpressibleByIntegerLiteral

extension Multiply: ExpressibleByIntegerLiteral where IntegerLiteralType == Value {
    public init(integerLiteral value: Value) {
        self.value = value
    }
}

// MARK: - Multiply: ExpressibleByFloatLiteral

extension Multiply: ExpressibleByFloatLiteral where FloatLiteralType == Value {
    public init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }
}

// MARK: - Multiply: Semigroup

extension Multiply: Semigroup {
    public static func <> (lhs: Multiply<Value>, rhs: Multiply<Value>) -> Multiply<Value> {
        Multiply(lhs.value * rhs.value)
    }
}

// MARK: - Multiply: Monoid

extension Multiply: Monoid {
    public static var empty: Multiply<Value> {
        Multiply(Value.one)
    }
}
