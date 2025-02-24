//
//  FunctionsTests.swift
//  functional-swift
//

import Prelude
import Testing

@Suite
struct FunctionsTests {
    private let plusOne: (Int) -> Int = { $0 + 1 }
    private let toString: (Int) -> String = String.init

    @Test("id(_:)")
    func testId() async {
        #expect(id(1) == 1)
        #expect(id("1") == "1")
    }

    @Test("const(_:)")
    func testConst() async {
        #expect(const(1)(0) == 1)
        #expect(const("1")("0") == "1")
    }

    @Test("|>")
    func testForewardPipeOperator() async {
        #expect(1 |> String.init == "1")
    }

    @Test("<|")
    func testBackwardPipeOperator() async {
        #expect(String.init <| 1 == "1")
    }

    @Test(">>>")
    func testForewardArrow() async {
        #expect(
            Optional(1).map(plusOne >>> toString)
                == .some("2")
        )
        #expect(
            Optional(1).map(plusOne).map(toString)
                == Optional(1).map(plusOne >>> toString)
        )
    }

    @Test("<<<")
    func testBackwardArrow() async {
        #expect(
            Optional(1).map(toString <<< plusOne)
                == .some("2")
        )
        #expect(
            Optional(1).map(toString <<< plusOne)
                == Optional(1).map(plusOne >>> toString)
        )
    }
}
