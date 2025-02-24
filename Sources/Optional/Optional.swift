//
//  Optional.swift
//  functional-swift
//

import Either
import Prelude

public extension Optional {
    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool {
        self != nil
    }

    func fold<Value>(
        _ fallback: @autoclosure () throws -> Value,
        _ transform: @escaping (Wrapped) throws -> Value
    ) rethrows -> Value {
        guard let self else {
            return try fallback()
        }
        return try transform(self)
    }

    func contains(_ element: Wrapped) -> Bool where Wrapped: Equatable {
        fold(false) { $0 == element }
    }

    func filter(_ predicate: (Wrapped) throws -> Bool) rethrows -> Optional<Wrapped> {
        try flatMap { value in
            try predicate(value) ? value : nil
        }
    }

    func filterNot(_ predicate: (Wrapped) throws -> Bool) rethrows -> Optional<Wrapped> {
        try flatMap { value in
            try predicate(value) ? nil : value
        }
    }

    func orElse(_ optional: Optional<Wrapped>) -> Optional<Wrapped> {
        fold(optional, pure)
    }

    func getOrElse(_ value: @autoclosure () throws -> Wrapped) rethrows -> Wrapped {
        try fold(value(), id)
    }

    func getOrThrow(error: @autoclosure () -> Error) throws -> Wrapped {
        guard let self else {
            throw error()
        }
        return self
    }

    func getOrFail<Failure: Error>(with failure: @autoclosure () -> Failure) throws(Failure) -> Wrapped {
        guard let self else {
            throw (failure())
        }
        return self
    }
}

public extension Optional {
    private struct UnwrappingError: Error, Equatable {}

    func zip<Other>(
        with other: Optional<Other>
    ) -> Optional<(Wrapped, Other)> {
        guard let self, let other else {
            return nil
        }
        return (self, other)
    }

    func zip<Other, each Another>(
        with other: Optional<Other>,
        _ another: repeat Optional<each Another>
    ) -> Optional<(Wrapped, Other, repeat each Another)> {
        guard let self, let other else {
            return nil
        }

        do {
            return try (
                self,
                other,
                repeat (each another).getOrThrow(error: UnwrappingError())
            )
        } catch {
            return nil
        }
    }
}

// MARK: Optional < Functor

public func <^> <A, B>(f: @escaping (A) -> B, a: Optional<A>) -> Optional<B> {
    a.map(f)
}

// MARK: Optional < Applicative Functor

public func pure<A>(_ a: A) -> Optional<A> {
    .some(a)
}

public func <*> <A, B>(ff: Optional<(A) -> B>, fa: Optional<A>) -> Optional<B> {
    fa.apply(ff)
}

public extension Optional {
    func apply<Value>(_ ff: Optional<(Wrapped) -> Value>) -> Optional<Value> {
        flatMap { value in
            ff.map { f in
                f(value)
            }
        }
    }
}

// MARK: Optional < Selective Applicative Functor

public func select<A, B>(_ fe: Optional<Either<A, B>>, _ ff: Optional<(A) -> B>) -> Optional<B> {
    guard let choice = fe else {
        return nil
    }
    switch choice {
    case let .right(b):
        return pure(b)
    case let .left(a):
        return ff <*> pure(a)
    }
}

public func branch<A, B, C>(_ fe: Optional<Either<A, B>>, _ ff: Optional<(A) -> C>, _ fg: Optional<(B) -> C>) -> Optional<C> {
    guard let choice = fe else {
        return nil
    }
    switch choice {
    case let .left(a):
        return ff <*> a
    case let .right(b):
        return fg <*> b
    }
}

// MARK: Optional < Monad

public func >>- <A, B>(fa: @escaping (A) -> Optional<B>, a: Optional<A>) -> Optional<B> {
    a.flatMap(fa)
}

public func >=> <A, B, C>(fa: @escaping (A) -> Optional<B>, fb: @escaping (B) -> Optional<C>) -> (A) -> Optional<C> {
    { a in fb >>- fa(a) }
}
