//
//  ComparableToTop.swift
//  functional-swift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - ComparableToTop

public protocol ComparableToTop: Comparable {
    static var max: Self { get }
}

// MARK: - Int Types < ComparableToTop

extension Int: ComparableToTop {}

extension Int8: ComparableToTop {}

extension Int16: ComparableToTop {}

extension Int32: ComparableToTop {}

extension Int64: ComparableToTop {}

#if canImport(Foundation)

// MARK: - Date < ComparableToTop

extension Date: ComparableToTop {
    public static var max: Date {
        Date.distantFuture
    }
}
#endif
