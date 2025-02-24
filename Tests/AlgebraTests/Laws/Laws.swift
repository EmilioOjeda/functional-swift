//
//  Laws.swift
//  functional-swift
//

import Algebra
import Prelude

// MARK: - Laws

enum Laws<Value: Equatable> { /* namespacing */ }

// MARK: .associativity(a:b:c:)

extension Laws where Value: Semigroup {
    static func associativity(a: Value, b: Value, c: Value) -> Bool {
        Associativity(a: a, b: b, c: c)
            .assert()
    }
}

// MARK: .identity(_:)

extension Laws where Value: Monoid {
    static func identity(_ value: Value) -> Bool {
        LeftIdentity(value).assert()
            && RightIdentity(value).assert()
    }
}

// MARK: - Law Types

private struct Associativity<Value: Equatable> {
    private let a: Value
    private let b: Value
    private let c: Value

    fileprivate init(a: Value, b: Value, c: Value) {
        self.a = a
        self.b = b
        self.c = c
    }

    fileprivate func assert() -> Bool where Value: Semigroup {
        a <> (b <> c) == (a <> b) <> c
    }
}

private struct LeftIdentity<Value: Equatable> {
    private let value: Value

    fileprivate init(_ value: Value) {
        self.value = value
    }

    fileprivate func assert() -> Bool where Value: Monoid {
        Value.empty <> value == value
    }
}

private struct RightIdentity<Value: Equatable> {
    private let value: Value

    fileprivate init(_ value: Value) {
        self.value = value
    }

    fileprivate func assert() -> Bool where Value: Monoid {
        value <> Value.empty == value
    }
}
