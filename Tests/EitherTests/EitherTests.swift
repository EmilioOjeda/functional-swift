//
//  EitherTests.swift
//  functional-swift
//

import Either
import Prelude
import Testing

@Suite
struct EitherTests {
    private struct FakeError: Error, Equatable {}

    @Test("isLeft")
    func testIsLeft() async {
        #expect(Either<Int, String>.left(1).isLeft)
        #expect(!Either<Int, String>.right("2").isLeft)
    }

    @Test("isRight")
    func testIsRight() async {
        #expect(!Either<Int, String>.left(1).isRight)
        #expect(Either<Int, String>.right("2").isRight)
    }

    @Test("swap()")
    func testSwap() async {
        #expect(Either<Int, String>.left(1).swap() == .right(1))
        #expect(Either<Int, String>.right("2").swap() == .left("2"))
    }

    @Test("fold(_:_:)")
    func testFold() async {
        #expect(Either<Int, String>.left(1).fold(const("1"), id) == "1")
        #expect(Either<Int, String>.right("2").fold(const(""), id) == "2")
    }

    @Test("contains(_:)")
    func testContains() async {
        #expect(Either<Int, String>.left(0).contains("value") == false)
        #expect(Either<Int, String>.right("value").contains("value") == true)
        #expect(Either<Int, String>.right("another value").contains("value") == false)
    }

    @Test("orElse(_:)")
    func testOrElse() async {
        #expect(Either<Int, String>.left(1).orElse(.right("2")) == .right("2"))
        #expect(Either<Int, String>.right("2").orElse(.left(1)) == .right("2"))
    }

    @Test("getOrElse(_:)")
    func testGetOrElse() async {
        #expect(Either<Int, String>.left(1).getOrElse("2") == "2")
        #expect(Either<Int, String>.right("2").getOrElse("1") == "2")
    }

    @Test("filterOrElse(_:or:)")
    func testFilterOrElse() async {
        #expect(Either<Int, String>.left(1).filterOrElse(const(false), or: 2) == .left(1))
        #expect(Either<Int, String>.right("1").filterOrElse(const(false), or: 2) == .left(2))
        #expect(Either<Int, String>.right("2").filterOrElse(const(true), or: 2) == .right("2"))
    }

    @Test("toOptional()")
    func testToOptional() async {
        #expect(Either<String, Int>.left("non-optional").toOptional() == .none)
        #expect(Either<String, Int>.right(0).toOptional() == .some(0))
    }

    @Test("toResult()")
    func testToResult() async {
        #expect(Either<FakeError, Int>.left(FakeError()).toResult() == .failure(FakeError()))
        #expect(Either<FakeError, Int>.right(0).toResult() == .success(0))
    }

    @Test("<^>")
    func testMapOperator() async {
        #expect(id <^> Either<Int, String>.left(1) == .left(1))
        #expect(id <^> Either<Int, String>.right("2") == .right("2"))
    }

    @Test("map(_:)")
    func testMap() async {
        #expect(Either<Int, String>.left(1).map(id) == .left(1))
        #expect(Either<Int, String>.right("2").map(id) == .right("2"))
    }

    @Test("<*>")
    func testApplyOperator() async {
        #expect(Either<Int, (String) -> String>.left(0) <*> pure("2") == .left(0))
        #expect(Either<Int, (String) -> String>.right(id) <*> pure("2") == .right("2"))
    }

    @Test("apply(_:)")
    func testApply() async {
        #expect(Either<Int, String>.left(1).apply(Either<Int, (String) -> String>.left(0)) == .left(1))
        #expect(Either<Int, String>.right("2").apply(Either<Int, (String) -> String>.left(1)) == .left(1))
        #expect(Either<Int, String>.right("2").apply(Either<Int, (String) -> String>.right(id)) == .right("2"))
    }

    @Test(">>-")
    func testBindOperator() async {
        #expect(pure >>- Either<Int, String>.left(1) == .left(1))
        #expect(pure >>- Either<Int, String>.right("2") == .right("2"))
    }

    @Test("flatMap(_:)")
    func testFlatMap() async {
        #expect(Either<Int, String>.left(1).flatMap(pure) == .left(1))
        #expect(Either<Int, String>.right("2").flatMap(pure) == .right("2"))
    }

    @Test(">=>")
    func testKleisliOperator() async {
        let plusOne: (Int) -> Either<Int, String> = { pure(String($0 + 1)) }
        let toString: (String) -> Either<Int, String> = pure
        #expect(plusOne >=> toString <| 1 == .right("2"))
    }
}
