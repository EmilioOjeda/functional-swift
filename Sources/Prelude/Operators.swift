//
//  Operators.swift
//  functional-swift
//

// MARK: - pipe

infix operator <|: infixr0
infix operator |>: infixl1

// MARK: - arrow

infix operator >>>: infixr9
infix operator <<<: infixr9

// MARK: - map -- functor

infix operator <^>: infixl4

// MARK: - apply -- applivative functor

infix operator <*>: infixl4

// MARK: - bind -- monad

infix operator >>-: infixl1

// MARK: - kleisli -- monad

infix operator >=>: infixr1

// MARK: - op -- semigroup

infix operator <>: infixr5
