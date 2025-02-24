//
//  ValidatedTests.swift
//  functional-swift
//

import Prelude
import Testing
@testable import Validated

@Suite
struct ValidatedTests {
    private struct FakeError: Error, Equatable {}

    private struct Pair<First: Equatable, Second: Equatable>: Equatable {
        let first: First
        let second: Second
    }

    private func nonEmpty<Value: Collection>(_ value: Value) -> Validated<[String], Value> {
        if value.isEmpty {
            return .invalid(["empty"])
        }
        return .valid(value)
    }

    private func minLength<Value: Collection>(_ length: Int) -> (Value) -> Validated<[String], Value> {
        { value in
            if value.count < length {
                return .invalid(["min-length"])
            }
            return .valid(value)
        }
    }

    @Test("isValid")
    func testIsValid() async {
        #expect(Validated<[String], Int>.invalid(["error"]).isValid == false)
        #expect(Validated<[String], Int>.valid(0).isValid == true)
    }

    @Test("isInvalid")
    func testIsInvalid() async {
        #expect(Validated<[String], Int>.invalid(["error"]).isInvalid == true)
        #expect(Validated<[String], Int>.valid(0).isInvalid == false)
    }

    @Test("fold(_:_:)")
    func testFold() async {
        #expect(
            Validated<[String], String>
                .invalid(["error"])
                .fold(const("error"), const("success"))
                == "error"
        )
        #expect(
            Validated<[String], String>
                .valid("success")
                .fold(const("error"), const("success"))
                == "success"
        )
    }

    @Test("toOptional()")
    func testToOptional() async {
        #expect(Validated<String, Int>.invalid("error").toOptional() == .none)
        #expect(Validated<String, Int>.valid(0).toOptional() == .some(0))
    }

    @Test("toResult()")
    func testToResult() async {
        #expect(Validated<FakeError, Int>.invalid(FakeError()).toResult() == .failure(FakeError()))
        #expect(Validated<FakeError, Int>.valid(0).toResult() == .success(0))
    }

    @Test("andThen(_:)")
    func testAndThen() async {
        #expect(
            Validated<[String], String>
                .invalid(["error"])
                .andThen(pure)
                == .invalid(["error"])
        )
        #expect(
            Validated<[String], String>
                .valid("success")
                .andThen(pure)
                == .valid("success")
        )
    }

    @Test("ensure(_:or:)")
    func testEnsureOr() async {
        #expect(
            Validated<String, String>
                .valid("")
                .ensure(const(false), on: "Must not be empty")
                == .invalid("Must not be empty")
        )
        #expect(
            Validated<String, String>
                .valid("-")
                .ensure(const(true), on: "Must not be empty")
                == .valid("-")
        )
    }

    @Test("ensure(_:on:)")
    func testEnsureOn() async {
        let isGreaterThan: (Int) -> (String) -> String = { minLength in
            { string in
                "Length must be greater than '\(minLength)'; provided value is '\(string)'"
            }
        }

        #expect(
            Validated<String, String>
                .valid("abc")
                .ensure(const(false), or: isGreaterThan(3))
                == .invalid("Length must be greater than '3'; provided value is 'abc'")
        )
        #expect(
            Validated<String, String>
                .valid("abcd")
                .ensure(const(true), or: isGreaterThan(3))
                == .valid("abcd")
        )
    }

    @Test("getOrElse(_:)")
    func testGetOrElse() async {
        #expect(
            Validated<String, String>
                .invalid("error")
                .getOrElse("fallback")
                == "fallback"
        )
        #expect(
            Validated<String, String>
                .valid("success")
                .getOrElse("fallback")
                == "success"
        )
    }

    @Test("combine(that:)")
    func testCombineThat() async {
        #expect(
            Validated<[String], String>
                .invalid(["error-1"])
                .combine(that: .invalid(["error-2"]))
                == .invalid(["error-1", "error-2"])
        )
        #expect(
            Validated<[String], String>
                .valid("a")
                .combine(that: .invalid(["error-2"]))
                == .invalid(["error-2"])
        )
        #expect(
            Validated<[String], String>
                .invalid(["error-1"])
                .combine(that: .valid("b"))
                == .invalid(["error-1"])
        )
        #expect(
            Validated<[String], String>
                .valid("a")
                .combine(that: .valid("b"))
                == .valid("ab")
        )
    }

    @Test("map(_:)")
    func testMap() async {
        #expect(
            Validated<[String], String>
                .invalid(["error"])
                .map(id)
                == .invalid(["error"])
        )
        #expect(
            Validated<[String], String>
                .valid("success")
                .map(id)
                == .valid("success")
        )
    }

    @Test("<^>")
    func testMapOperator() async {
        #expect(id <^> Validated<[String], String>.invalid(["error"]) == .invalid(["error"]))
        #expect(id <^> Validated<[String], String>.valid("success") == .valid("success"))
    }

    @Test("apply(_:)")
    func testApply() async {
        #expect(Validated<[String], String>.invalid(["error"]).apply(pure(id)) == .invalid(["error"]))
        #expect(Validated<[String], String>.valid("success").apply(pure(id)) == .valid("success"))
    }

    @Test("<*>")
    func testApplyOperator() async {
        #expect(
            pure(curry(Pair.init))
                <*> (nonEmpty <| "")
                <*> (minLength(4) <| "1234")
                == .invalid(["empty"])
        )
        #expect(
            pure(curry(Pair.init))
                <*> (nonEmpty <| "-")
                <*> (minLength(4) <| "123")
                == .invalid(["min-length"])
        )
        #expect(
            pure(curry(Pair.init))
                <*> (nonEmpty <| "")
                <*> (minLength(4) <| "123")
                == .invalid(["empty", "min-length"])
        )
        #expect(
            pure(curry(Pair.init))
                <*> (nonEmpty <| "-")
                <*> (minLength(4) <| "1234")
                == .valid(Pair(first: "-", second: "1234"))
        )
    }
}
