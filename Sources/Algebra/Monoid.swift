//
//  Monoid.swift
//  functional-swift
//

// MARK: - Monoid

public protocol Monoid: Semigroup {
    static var empty: Self { get }
}

public func concat<M: Monoid>(_ values: [M]) -> M {
    values.reduce(M.empty, <>)
}

// MARK: - String: Monoid

extension String: Monoid {
    public static let empty: String = ""
}

// MARK: - Array: Monoid

extension Array: Monoid {
    public static var empty: [Element] { [] }
}

// MARK: - Optional: Monoid

extension Optional: Monoid where Wrapped: Semigroup {
    public static var empty: Optional<Wrapped> { .none }
}
