//
//  Multiplication.swift
//  functional-swift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Multiplication

public protocol Multiplication: Numeric {
    static var one: Self { get }
}

// MARK: - Int Types < Multiplication

extension Int: Multiplication {
    public static let one: Int = 1
}

extension Int8: Multiplication {
    public static let one: Int8 = 1
}

extension Int16: Multiplication {
    public static let one: Int16 = 1
}

extension Int32: Multiplication {
    public static let one: Int32 = 1
}

extension Int64: Multiplication {
    public static let one: Int64 = 1
}

// MARK: - Float Types < Multiplication

extension Double: Multiplication {
    public static let one: Double = 1
}

extension Float: Multiplication {
    public static let one: Float = 1
}

#if canImport(Foundation)
extension CGFloat: Multiplication {
    public static let one: CGFloat = 1
}
#endif
