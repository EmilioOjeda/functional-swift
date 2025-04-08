//
//  MonoidTests.swift
//  functional-swift
//

@testable import Algebra
#if canImport(Foundation)
import Foundation
#endif
import Testing

@Suite
struct MonoidTests {
    @Test("concat<monoid>")
    func testConcat() async {
        #expect("abc" == concat(["a", "b", "c"]))
        #expect(Min(1) == concat([1, 2, 3]))
        #expect(Max(3) == concat([1, 2, 3]))
        #if canImport(Foundation)
        let now = Date()
        #expect(Min(now) == concat([Min(now), Min(now.advanced(by: 1)), Min(now.advanced(by: 2))]))
        #expect(Max(now) == concat([Max(now), Max(now.advanced(by: -1)), Max(now.advanced(by: -2))]))
        #endif
    }

    @Test("String: Monoid")
    func testString() async {
        #expect(
            Laws.identity("a")
        )
    }

    @Test("Array: Monoid")
    func testArray() async {
        #expect(
            Laws.identity(["a"])
        )
    }

    @Test("Optional: Monoid")
    func testOptional() async {
        #expect(
            Laws.identity(Optional("a"))
        )
    }

    @Test("Add<Int>: Monoid")
    func testAddInt() async {
        #expect(
            Laws.identity(Add(Int(1)))
        )
    }

    @Test("Add<Int8>: Monoid")
    func testAddInt8() async {
        #expect(
            Laws.identity(Add(Int8(1)))
        )
    }

    @Test("Add<Int16>: Monoid")
    func testAddInt16() async {
        #expect(
            Laws.identity(Add(Int16(1)))
        )
    }

    @Test("Add<Int32>: Monoid")
    func testAddInt32() async {
        #expect(
            Laws.identity(Add(Int32(1)))
        )
    }

    @Test("Add<Int64>: Monoid")
    func testAddInt64() async {
        #expect(
            Laws.identity(Add(Int64(1)))
        )
    }

    @Test("Add<Double>: Monoid")
    func testAddDouble() async {
        #expect(
            Laws.identity(Add(Double(1.0)))
        )
    }

    @Test("Add<Float>: Monoid")
    func testAddFloat() async {
        #expect(
            Laws.identity(Add(Float(1)))
        )
    }

    #if canImport(Foundation)
    @Test("Add<CGFloat>: Monoid")
    func testAddCGFloat() async {
        #expect(
            Laws.identity(Add(CGFloat(1)))
        )
    }
    #endif

    @Test("Multiply<Int>: Monoid")
    func testMultiplyInt() async {
        #expect(
            Laws.identity(Multiply(Int(1)))
        )
    }

    @Test("Multiply<Int8>: Monoid")
    func testMultiplyInt8() async {
        #expect(
            Laws.identity(Multiply(Int8(1)))
        )
    }

    @Test("Multiply<Int16>: Monoid")
    func testMultiplyInt16() async {
        #expect(
            Laws.identity(Multiply(Int16(1)))
        )
    }

    @Test("Multiply<Int32>: Monoid")
    func testMultiplyInt32() async {
        #expect(
            Laws.identity(Multiply(Int32(1)))
        )
    }

    @Test("Multiply<Int64>: Monoid")
    func testMultiplyInt64() async {
        #expect(
            Laws.identity(Multiply(Int64(1)))
        )
    }

    @Test("Multiply<Double>: Monoid")
    func testMultiplyDouble() async {
        #expect(
            Laws.identity(Multiply(Double(1.0)))
        )
    }

    @Test("Multiply<Float>: Monoid")
    func testMultiplyFloat() async {
        #expect(
            Laws.identity(Multiply(Float(1)))
        )
    }

    #if canImport(Foundation)
    @Test("Multiply<CGFloat>: Monoid")
    func testMultiplyCGFloat() async {
        #expect(
            Laws.identity(Multiply(CGFloat(1)))
        )
    }
    #endif

    @Test("Or: Monoid", arguments: [Or]([true, false]))
    func testOr(value: Or) async {
        #expect(
            Laws.identity(value)
        )
    }

    @Test("And: Monoid", arguments: [And]([true, false]))
    func testAnd(value: And) async {
        #expect(
            Laws.identity(value)
        )
    }

    @Test("Min<Int>: Monoid")
    func testMinInt() async {
        #expect(
            Laws.identity(Min(Int(1)))
        )
    }

    @Test("Min<Int8>: Monoid")
    func testMinInt8() async {
        #expect(
            Laws.identity(Min(Int8(1)))
        )
    }

    @Test("Min<Int16>: Monoid")
    func testMinInt16() async {
        #expect(
            Laws.identity(Min(Int16(1)))
        )
    }

    @Test("Min<Int32>: Monoid")
    func testMinInt32() async {
        #expect(
            Laws.identity(Min(Int32(1)))
        )
    }

    @Test("Min<Int64>: Monoid")
    func testMinInt64() async {
        #expect(
            Laws.identity(Min(Int64(1)))
        )
    }

    #if canImport(Foundation)
    @Test("Min<Date>: Monoid")
    func testMinDate() async {
        #expect(
            Laws.identity(Min(Date()))
        )
    }
    #endif

    @Test("Max<Int>: Monoid")
    func testMaxInt() async {
        #expect(
            Laws.identity(Max(Int(1)))
        )
    }

    @Test("Max<Int8>: Monoid")
    func testMaxInt8() async {
        #expect(
            Laws.identity(Max(Int8(1)))
        )
    }

    @Test("Max<Int16>: Monoid")
    func testMaxInt16() async {
        #expect(
            Laws.identity(Max(Int16(1)))
        )
    }

    @Test("Max<Int32>: Monoid")
    func testMaxInt32() async {
        #expect(
            Laws.identity(Max(Int32(1)))
        )
    }

    @Test("Max<Int64>: Monoid")
    func testMaxInt64() async {
        #expect(
            Laws.identity(Max(Int64(1)))
        )
    }

    #if canImport(Foundation)
    @Test("Max<Date>: Monoid")
    func testMaxDate() async {
        #expect(
            Laws.identity(Max(Date()))
        )
    }
    #endif
}
