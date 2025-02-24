//
//  SemigroupTests.swift
//  functional-swift
//

@testable import Algebra
#if canImport(CoreFoundation)
import CoreFoundation
#endif
#if canImport(Foundation)
import Foundation
#endif
import Testing

@Suite
struct SemigroupTests {
    @Test("concat<semigroup>")
    func testConcat() async {
        #expect("abc" == concat("a", ["b", "c"]))
        #expect(Min(1) == concat(2, [3, 1]))
        #expect(Max(3) == concat(2, [1, 3]))
        #if canImport(Foundation)
        let now = Date()
        #expect(Min(now) == concat(Min(now), [Min(now.advanced(by: 1)), Min(now.advanced(by: 2))]))
        #expect(Max(now) == concat(Max(now), [Max(now.advanced(by: -1)), Max(now.advanced(by: -2))]))
        #endif
    }

    @Test("String: Semigroup")
    func testString() async {
        #expect(
            Laws.associativity(a: "a", b: "b", c: "c")
        )
    }

    @Test("Array: Semigroup")
    func testArray() async {
        #expect(
            Laws.associativity(a: ["a"], b: ["b"], c: ["c"])
        )
    }

    @Test("Optional: Semigroup")
    func testOptional() async {
        #expect(
            Laws.associativity(a: Optional("a"), b: Optional("b"), c: Optional("c"))
        )
    }

    @Test("Add<Int>: Semigroup")
    func testAddInt() async {
        #expect(
            Laws.associativity(a: Add(1), b: Add(2), c: Add(3))
        )
    }

    @Test("Add<Int8>: Semigroup")
    func testAddInt8() async {
        #expect(
            Laws.associativity(a: Add(Int8(1)), b: Add(Int8(2)), c: Add(Int8(3)))
        )
    }

    @Test("Add<Int16>: Semigroup")
    func testAddInt16() async {
        #expect(
            Laws.associativity(a: Add(Int16(1)), b: Add(Int16(2)), c: Add(Int16(3)))
        )
    }

    @Test("Add<Int32>: Semigroup")
    func testAddInt32() async {
        #expect(
            Laws.associativity(a: Add(Int32(1)), b: Add(Int32(2)), c: Add(Int32(3)))
        )
    }

    @Test("Add<Int64>: Semigroup")
    func testAddInt64() async {
        #expect(
            Laws.associativity(a: Add(Int64(1)), b: Add(Int64(2)), c: Add(Int64(3)))
        )
    }

    @Test("Add<Double>: Semigroup")
    func testAddDouble() async {
        #expect(
            Laws.associativity(a: Add(1.0), b: Add(2.0), c: Add(3.0))
        )
    }

    @Test("Add<Float>: Semigroup")
    func testAddFloat() async {
        #expect(
            Laws.associativity(a: Add(Float(1)), b: Add(Float(2)), c: Add(Float(3)))
        )
    }

    #if canImport(CoreFoundation)
    @Test("Add<CGFloat>: Semigroup")
    func testAddCGFloat() async {
        #expect(
            Laws.associativity(a: Add(CGFloat(1)), b: Add(CGFloat(2)), c: Add(CGFloat(3)))
        )
    }
    #endif

    @Test("Multiply<Int>: Semigroup")
    func testMultiplyInt() async {
        #expect(
            Laws.associativity(a: Multiply(1), b: Multiply(2), c: Multiply(3))
        )
    }

    @Test("Multiply<Int8>: Semigroup")
    func testMultiplyInt8() async {
        #expect(
            Laws.associativity(a: Multiply(Int8(1)), b: Multiply(Int8(2)), c: Multiply(Int8(3)))
        )
    }

    @Test("Multiply<Int16>: Semigroup")
    func testMultiplyInt16() async {
        #expect(
            Laws.associativity(a: Multiply(Int16(1)), b: Multiply(Int16(2)), c: Multiply(Int16(3)))
        )
    }

    @Test("Multiply<Int32>: Semigroup")
    func testMultiplyInt32() async {
        #expect(
            Laws.associativity(a: Multiply(Int32(1)), b: Multiply(Int32(2)), c: Multiply(Int32(3)))
        )
    }

    @Test("Multiply<Int64>: Semigroup")
    func testMultiplyInt64() async {
        #expect(
            Laws.associativity(a: Multiply(Int64(1)), b: Multiply(Int64(2)), c: Multiply(Int64(3)))
        )
    }

    @Test("Multiply<Double>: Semigroup")
    func testMultiplyDouble() async {
        #expect(
            Laws.associativity(a: Multiply(1.0), b: Multiply(2.0), c: Multiply(3.0))
        )
    }

    @Test("Multiply<Float>: Semigroup")
    func testMultiplyFloat() async {
        #expect(
            Laws.associativity(a: Multiply(Float(1)), b: Multiply(Float(2)), c: Multiply(Float(3)))
        )
    }

    #if canImport(CoreFoundation)
    @Test("Multiply<CGFloat>: Semigroup")
    func testMultiplyCGFloat() async {
        #expect(
            Laws.associativity(a: Multiply(CGFloat(1)), b: Multiply(CGFloat(2)), c: Multiply(CGFloat(3)))
        )
    }
    #endif

    @Test("Or: Semigroup", arguments: [(a: Or, b: Or, c: Or)]([
        (a: true, b: false, c: false),
        (a: false, b: true, c: false),
        (a: false, b: false, c: true),
        (a: false, b: false, c: false)
    ]))
    func testOr(a: Or, b: Or, c: Or) async {
        #expect(
            Laws.associativity(a: a, b: b, c: c)
        )
    }

    @Test("And: Semigroup", arguments: [(a: And, b: And, c: And)]([
        (a: true, b: false, c: false),
        (a: false, b: true, c: false),
        (a: false, b: false, c: true),
        (a: false, b: false, c: false)
    ]))
    func testAnd(a: And, b: And, c: And) async {
        #expect(
            Laws.associativity(a: a, b: b, c: c)
        )
    }

    @Test("Min<Int>: Semigroup")
    func testMinInt() async {
        #expect(
            Laws.associativity(a: Min(1), b: Min(2), c: Min(3))
        )
    }

    @Test("Min<Int8>: Semigroup")
    func testMinInt8() async {
        #expect(
            Laws.associativity(a: Min(Int8(1)), b: Min(Int8(2)), c: Min(Int8(3)))
        )
    }

    @Test("Min<Int16>: Semigroup")
    func testMinInt16() async {
        #expect(
            Laws.associativity(a: Min(Int16(1)), b: Min(Int16(2)), c: Min(Int16(3)))
        )
    }

    @Test("Min<Int32>: Semigroup")
    func testMinInt32() async {
        #expect(
            Laws.associativity(a: Min(Int32(1)), b: Min(Int32(2)), c: Min(Int32(3)))
        )
    }

    @Test("Min<Int64>: Semigroup")
    func testMinInt364() async {
        #expect(
            Laws.associativity(a: Min(Int64(1)), b: Min(Int64(2)), c: Min(Int64(3)))
        )
    }

    #if canImport(Foundation)
    @Test("Min<Date>: Semigroup")
    func testMinDate() async {
        let date = Date(timeIntervalSince1970: 0)
        #expect(
            Laws.associativity(a: Min(date), b: Min(date.advanced(by: 1)), c: Min(date.advanced(by: 2)))
        )
    }
    #endif

    @Test("Max<Int>: Semigroup")
    func testMaxInt() async {
        #expect(
            Laws.associativity(a: Max(1), b: Max(2), c: Max(3))
        )
    }

    @Test("Max<Int8>: Semigroup")
    func testMaxInt8() async {
        #expect(
            Laws.associativity(a: Max(Int8(1)), b: Max(Int8(2)), c: Max(Int8(3)))
        )
    }

    @Test("Max<Int16>: Semigroup")
    func testMaxInt16() async {
        #expect(
            Laws.associativity(a: Max(Int16(1)), b: Max(Int16(2)), c: Max(Int16(3)))
        )
    }

    @Test("Max<Int32>: Semigroup")
    func testMaxInt32() async {
        #expect(
            Laws.associativity(a: Max(Int32(1)), b: Max(Int32(2)), c: Max(Int32(3)))
        )
    }

    @Test("Max<Int64>: Semigroup")
    func testMaxInt364() async {
        #expect(
            Laws.associativity(a: Max(Int64(1)), b: Max(Int64(2)), c: Max(Int64(3)))
        )
    }

    #if canImport(Foundation)
    @Test("Max<Date>: Semigroup")
    func testMaxDate() async {
        let date = Date()
        #expect(
            Laws.associativity(a: Max(date), b: Max(date.advanced(by: 1)), c: Max(date.advanced(by: 2)))
        )
    }
    #endif
}
