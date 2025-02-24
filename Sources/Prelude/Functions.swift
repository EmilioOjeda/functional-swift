//
//  Functions.swift
//  functional-swift
//

public func id<A>(_ a: A) -> A { a }

public func const<A, B>(_ a: A) -> (B) -> A {
    { _ in a }
}

public func >>> <A, B, C>(_ fa: @escaping (A) -> B, _ fb: @escaping (B) -> C) -> (A) -> C {
    { a in fb(fa(a)) }
}

public func <<< <A, B, C>(_ fb: @escaping (B) -> C, _ fa: @escaping (A) -> B) -> (A) -> C {
    { a in fb(fa(a)) }
}

public func <| <A, B>(f: @escaping (A) -> B, a: A) -> B { f(a) }

public func |> <A, B>(a: A, f: @escaping (A) -> B) -> B { f(a) }

public func curry<First, each Others, Value>(
    _ f: @escaping (First, repeat each Others) -> Value
) -> (First) -> (repeat each Others) -> Value {
    { (first: First) in
        { (others: repeat each Others) in
            f(first, repeat each others)
        }
    }
}
