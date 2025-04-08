//
//  Addition.swift
//  functional-swift
//

#if canImport(Foundation)
import Foundation
#endif

// MARK: - Addition

public protocol Addition: Numeric {
    static var zero: Self { get }
}

// MARK: - Int Types < Addition

extension Int: Addition {
    public static let zero: Int = 0
}

extension Int8: Addition {
    public static let zero: Int8 = 0
}

extension Int16: Addition {
    public static let zero: Int16 = 0
}

extension Int32: Addition {
    public static let zero: Int32 = 0
}

extension Int64: Addition {
    public static let zero: Int64 = 0
}

// MARK: - Float Types < Addition

extension Double: Addition {
    public static let zero: Double = 0
}

extension Float: Addition {
    public static let zero: Float = 0
}

#if canImport(Foundation)
extension CGFloat: Addition {
    public static let zero: CGFloat = 0
}
#endif
