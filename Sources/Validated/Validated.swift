//
//  Validated.swift
//  functional-swift
//

import Algebra
import Prelude

public enum Validated<F, A> {
    case valid(A)
    case invalid(F)

    public var isValid: Bool {
        switch self {
        case .valid: true
        case .invalid: false
        }
    }

    public var isInvalid: Bool { !isValid }

    public func fold<B>(_ fe: (F) -> B, _ fa: (A) -> B) -> B {
        switch self {
        case let .valid(a): fa(a)
        case let .invalid(e): fe(e)
        }
    }

    public func toOptional() -> Optional<A> {
        fold(const(.none), Optional.some)
    }

    public func toResult() -> Result<A, F> where F: Error {
        fold(Result.failure, Result.success)
    }
}

extension Validated: Equatable where F: Equatable, A: Equatable {}
extension Validated: Hashable where F: Hashable, A: Hashable {}
extension Validated: Sendable where F: Sendable, A: Sendable {}

public extension Validated {
    func andThen<B>(_ fa: (A) -> Validated<F, B>) -> Validated<F, B> {
        fold(Validated<F, B>.invalid, fa)
    }

    func ensure(_ predicate: (A) -> Bool, or f: (A) -> F) -> Validated<F, A> {
        fold(Validated<F, A>.invalid) { value in
            predicate(value) ? pure(value) : .invalid(f(value))
        }
    }

    func ensure(_ predicate: (A) -> Bool, on failure: @autoclosure () -> F) -> Validated<F, A> {
        fold(Validated<F, A>.invalid) { value in
            predicate(value) ? pure(value) : .invalid(failure())
        }
    }

    func getOrElse(_ value: @autoclosure () -> A) -> A {
        fold(const(value()), id)
    }
}

public extension Validated where F: Semigroup, A: Semigroup {
    func combine(that validated: Validated<F, A>) -> Validated<F, A> {
        switch (self, validated) {
        case let (.valid(value), .valid(otherValue)):
            .valid(value <> otherValue)
        case let (.invalid(error), .invalid(otherError)):
            .invalid(error <> otherError)
        case let (.invalid(error), _), let (_, .invalid(error)):
            .invalid(error)
        }
    }
}

// MARK: - Validated < Functor

public func <^> <F, A, B>(f: (A) -> B, a: Validated<F, A>) -> Validated<F, B> {
    a.map(f)
}

public extension Validated {
    func map<B>(_ f: (A) -> B) -> Validated<F, B> {
        fold(Validated<F, B>.invalid) { value in
            pure(f(value))
        }
    }
}

// MARK: - Validated < Applicative

func pure<F, A>(_ value: A) -> Validated<F, A> {
    .valid(value)
}

public func <*> <F: Semigroup, A, B>(ff: Validated<F, (A) -> B>, fa: Validated<F, A>) -> Validated<F, B> {
    fa.apply(ff)
}

public extension Validated where F: Semigroup {
    func apply<B>(_ ff: Validated<F, (A) -> B>) -> Validated<F, B> {
        switch (ff, self) {
        case let (.valid(f), .valid(a)):
            pure(f(a))
        case let (.invalid(errors), .invalid(otherErrors)):
            .invalid(errors <> otherErrors)
        case let (.invalid(errors), _), let (_, .invalid(errors)):
            .invalid(errors)
        }
    }
}
