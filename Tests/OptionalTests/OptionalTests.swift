//
//  OptionalTests.swift
//  functional-swift
//

import Either
import Optional
import Prelude
import Testing

@Suite
struct OptionalTests {
    private let plusOne: (Int) -> Int = { $0 + 1 }
    private let toInt: (String) -> Int? = Int.init
    private let toString: (Int) -> String = { String($0) }

    private struct FakeError: Error, Equatable {}

    @Test("isNil")
    func testIsNil() async {
        #expect(Optional<Int>.none.isNil)
        #expect(Optional<Int>.some(1).isNil == false)
    }

    @Test("isNotNil")
    func testIsNotNil() async {
        #expect(Optional<Int>.none.isNotNil == false)
        #expect(Optional<Int>.some(1).isNotNil)
    }

    @Test("contains(_:)")
    func testContains() async {
        #expect(Optional<String>.none.contains("value") == false)
        #expect(Optional<String>.some("value").contains("value") == true)
        #expect(Optional<String>.some("value").contains("another value") == false)
    }

    @Test("filter(_:)")
    func testFilter() async {
        #expect(Optional<Int>.none.filter(const(true)) == .none)
        #expect(Optional<Int>.some(1).filter(const(false)) == .none)
        #expect(Optional<Int>.some(1).filter(const(true)) == .some(1))
    }

    @Test("filterNot(_:)")
    func testFilterNot() async {
        #expect(Optional<Int>.none.filterNot(const(true)) == .none)
        #expect(Optional<Int>.some(1).filterNot(const(true)) == .none)
        #expect(Optional<Int>.some(1).filterNot(const(false)) == .some(1))
    }

    @Test("orElse(_:)")
    func testOrElse() async {
        #expect(Optional<Int>.none.orElse(.none) == .none)
        #expect(Optional<Int>.none.orElse(.some(1)) == .some(1))
        #expect(Optional<Int>.some(1).orElse(.some(0)) == .some(1))
    }

    @Test("getOrElse(_:)")
    func testGetOrElse() async {
        #expect(Optional<Int>.none.getOrElse(1) == 1)
        #expect(Optional<Int>.some(1).getOrElse(0) == 1)
    }

    @Test("getOrThrow(error:)")
    func testGetOrThrow() async throws {
        #expect(throws: FakeError.self) {
            try Optional<Int>.none.getOrThrow(error: FakeError())
        }
        #expect(throws: Never.self) {
            try Optional<Int>.some(1).getOrThrow(error: FakeError())
        }
    }

    @Test("getOrFail(with:)")
    func testGetOrFail() async throws {
        #expect(throws: FakeError.self) {
            try Optional<Int>.none.getOrFail(with: FakeError())
        }
        #expect(throws: Never.self) {
            try Optional<Int>.some(1).getOrFail(with: FakeError())
        }
    }

    @Test("zip(with:)")
    func testZipWith() async throws {
        #expect(Optional<Int>.none.zip(with: pure(1)) == nil)
        let (first, second) = try #require(Optional<Int>.some(0).zip(with: pure(1)))
        #expect(first == 0)
        #expect(second == 1)
    }

    @Test("zip(with:_:)")
    func testZipWithOthers() async throws {
        #expect(Optional<Int>.none.zip(with: Optional(2), Optional(3)).isNil)
        #expect(Optional(1).zip(with: Optional<Int>.none, Optional(3)).isNil)
        #expect(Optional(1).zip(with: Optional(2), Optional<Int>.none).isNil)
        let (first, second, third) = try #require(Optional(1).zip(with: Optional(2), Optional(3)))
        #expect(first == 1 && second == 2 && third == 3)
    }

    @Test("<^>")
    func testMapOperator() async {
        #expect(plusOne <^> nil == .none)
        #expect(plusOne <^> pure(1) == .some(2))
    }

    @Test("apply(_:)")
    func testApply() async {
        #expect(Optional<Int>.none.apply(const(1)) == .none)
        #expect(Optional<Int>.some(0).apply(const(1)) == .some(1))
    }

    @Test("<*>")
    func testApplyOperator() async {
        #expect(pure { $0 + 1 } <*> Optional(1) == .some(2))
    }

    @Test("select(_:_:)")
    func testSelect() async {
        #expect(select(.none, pure(id)) == .none)
        #expect(select(pure(.left("a")), pure(id)) == .some("a"))
        #expect(select(pure(.right("b")), pure(id)) == .some("b"))
    }

    @Test("branch(_:_:_:)")
    func testBranch() async {
        #expect(branch(.none, pure(id), pure(id)) == .none)
        #expect(branch(pure(.left("a")), pure(id), pure(id)) == .some("a"))
        #expect(branch(pure(.right("b")), pure(id), pure(id)) == .some("b"))
    }

    @Test(">>-")
    func testBindOperator() async {
        #expect(toInt >>- nil == .none)
        #expect(toInt >>- pure("1") == .some(1))
    }

    @Test(">=>")
    func testKleisliOperator() async {
        #expect(plusOne >=> toString <| 1 == .some("2"))
    }
}
