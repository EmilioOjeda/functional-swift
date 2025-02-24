//
//  ComparableToBottom.swift
//  functional-swift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - ComparableToBottom

public protocol ComparableToBottom: Comparable {
    static var min: Self { get }
}

// MARK: - Int Types < ComparableToBottom

extension Int: ComparableToBottom {}

extension Int8: ComparableToBottom {}

extension Int16: ComparableToBottom {}

extension Int32: ComparableToBottom {}

extension Int64: ComparableToBottom {}

#if canImport(Foundation)

// MARK: - Date < ComparableToBottom

extension Date: ComparableToBottom {
    public static var min: Date {
        Date.distantPast
    }
}
#endif
