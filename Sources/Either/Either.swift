//
//  Either.swift
//  functional-swift
//

import Prelude

public enum Either<E, A> {
    case left(E)
    case right(A)

    public var isLeft: Bool {
        switch self {
        case .left: true
        case .right: false
        }
    }

    public var isRight: Bool { !isLeft }

    public func swap() -> Either<A, E> {
        switch self {
        case let .left(e): .right(e)
        case let .right(a): .left(a)
        }
    }

    public func fold<B>(_ fe: (E) -> B, _ fa: (A) -> B) -> B {
        switch self {
        case let .left(e): fe(e)
        case let .right(a): fa(a)
        }
    }

    public func contains(_ value: A) -> Bool where A: Equatable {
        fold(const(false)) { $0 == value }
    }

    public func orElse(_ either: Either<E, A>) -> Either<E, A> {
        fold(const(either), pure)
    }

    public func getOrElse(_ value: @autoclosure () -> A) -> A {
        fold(const(value()), id)
    }

    public func filterOrElse(_ predicate: (A) -> Bool, or value: @autoclosure () -> E) -> Either<E, A> {
        flatMap { a in
            predicate(a) ? pure(a) : .left(value())
        }
    }

    public func toOptional() -> Optional<A> {
        fold(const(.none), Optional.some)
    }

    public func toResult() -> Result<A, E> where E: Error {
        fold(Result.failure, Result.success)
    }
}

extension Either: Equatable where E: Equatable, A: Equatable {}
extension Either: Hashable where E: Hashable, A: Hashable {}
extension Either: Sendable where E: Sendable, A: Sendable {}

// MARK: Either < Functor

public func <^> <E, A, B>(f: (A) -> B, a: Either<E, A>) -> Either<E, B> {
    a.map(f)
}

public extension Either {
    func map<B>(_ f: (A) -> B) -> Either<E, B> {
        fold(Either<E, B>.left) { a in
            pure(f(a))
        }
    }
}

// MARK: Either < Applicative Functor

public func pure<E, A>(_ a: A) -> Either<E, A> {
    .right(a)
}

public func <*> <E, A, B>(ff: Either<E, (A) -> B>, fa: Either<E, A>) -> Either<E, B> {
    fa.apply(ff)
}

public extension Either {
    func apply<B>(_ ff: Either<E, (A) -> B>) -> Either<E, B> {
        flatMap { a in
            ff.map { f in
                f(a)
            }
        }
    }
}

// MARK: Either < Monad

public func >>- <E, A, B>(fa: @escaping (A) -> Either<E, B>, a: Either<E, A>) -> Either<E, B> {
    a.flatMap(fa)
}

public extension Either {
    func flatMap<B>(_ f: (A) -> Either<E, B>) -> Either<E, B> {
        fold(Either<E, B>.left, f)
    }
}

public func >=> <E, A, B, C>(fa: @escaping (A) -> Either<E, B>, fb: @escaping (B) -> Either<E, C>) -> (A) -> Either<E, C> {
    { a in fb >>- fa(a) }
}
