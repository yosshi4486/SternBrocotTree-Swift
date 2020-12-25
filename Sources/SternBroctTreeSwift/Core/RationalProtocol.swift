//
//  RationalProtocol.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A protocol that represents rational.
///
/// Rational is number that can represent it as ratio of two integer values.
public protocol RationalProtocol : SBTreeNode, Comparable, Hashable, CustomFloatConvertible, CustomDoubleConvertible, CustomDecimalConvertible {

    /// Returns zero representation of sternbrocot-tree.
    static var zero: Self { get }

    /// Returns infinity representation of sternbrocot-tree.
    static var infinity: Self { get }

    /// The denominator of the rational number.
    var denominator: Int32 { get set }

    /// The numerator of the rational number.
    var numerator: Int32 { get set }
    

    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Precondition:
    /// The denominator must not be zero.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    init(numerator: Int32, denominator: Int32)

    /// Creates an instance initizalized by the given string value splited by `/` separator.
    ///
    /// In some cases, Initialized by string literal is more readable in terms of use.
    ///
    /// - Precondition:
    /// The denominator must not be zero.
    ///
    /// - Parameter stringValue: The string value represents a fruction.
    init(_ stringValue: String)

    /// Returns a value wether this value can simplify or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    var canSimplify: Bool { get }

    /// Returns a new simplified rational.
    ///
    /// Returns new value when the numerator and the denominator have common devider except for ± 1,
    ///
    ///     let new = Rational(fraction: "3/9").simplified
    ///     // new.description is 1/3.
    ///
    /// otherwise always returns self.
    ///
    ///     let new = Rational(fraction: "3/10").simplified
    ///     // new.description is 3/10.
    ///
    /// - Note:
    /// `Reduce` is term used to reduce numerics by gcm, but  `simplified` execute sign inversion of the numerator and the denominator in addition.
    func simplified() -> Self

    /// Returns the sum of this value and the given value **in simplified form**.
    ///
    /// - Parameter other: The value to add to this value.
    /// - Throws: An AddingError may be thrown.
    /// - Returns: A rational that is added.
    func adding(to other: Self) throws -> Self

    /// Returns the defference obtained by subtracting the given value from this value **in simplified form**.
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is subtracted.
    func subtracting(_ other: Self) throws -> Self

    /// Returns the product of this value and the given value **in simplified form**.
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is multiplied.
    func multiplied(by other: Self) throws -> Self

    /// Returns the quatient obtained by dividing this value by the given value **in simplified form**.
    ///
    /// - Parameter other: The value to divide this value by.
    /// - Throws: An AddingError may be thrown.
    /// - Returns: A rational that is devided.
    func divided(by other: Self) throws -> Self

    /// Returns a mediant from two fractions.
    static func mediant(left: Self, right: Self) throws -> Self

    /// Returns a boolean value whether this and the other are adjacent.
    ///
    /// - Parameter other: The other concrete rational to determine adjacent.
    /// - Returns: The two values are adjacent or not.
    func isAdjacent(to other: Self) -> Bool

    /// Returns backwarding matrix sequence.
    func backwardingMatrixSequence() -> [Matrix2x2]

}

extension RationalProtocol {

    /// Returns a boolean value whether this and the other are adjacent.
    ///
    /// - Parameter other: The other concrete rational to determine adjacent.
    /// - Returns: The two values are adjacent or not.
    public func isAdjacent(to other: Self) -> Bool {
        let ad = Int64(numerator * other.denominator)
        let bc = Int64(denominator * other.numerator)
        return abs(ad - bc) == 1
    }

    /// Returns simplicity of a rational.
    ///
    /// if **r=a/b** is in reduced form, **the simplicity of r** is defined to be **L(r)≡1/ab**.
    var simplicity: Self {
        let ab = Int64(numerator * denominator)
        return Self("1/\(ab)")
    }

    /// Returns total of a rational.
    ///
    /// if **r=a/b** is in reduced form, define the total of r to be **t(r) ≡ a+b**.
    var total: Int32 {
        return numerator + denominator
    }

    /// Returns a mediant from two fractions.
    public static func mediant(left: Self, right: Self) throws -> Self {

        let (numeratorAddingResult, numeratorAddingOverflow) = left.numerator.addingReportingOverflow(right.numerator)
        let (denominatorAddingResult, denominatorAddingOverflow) = left.denominator.addingReportingOverflow(right.denominator)

        if numeratorAddingOverflow || denominatorAddingOverflow {
            throw RationalError.overflow(lhs: left, rhs: right)
        }

        return Self(numerator: numeratorAddingResult,denominator: denominatorAddingResult)
    }

    public func backwardingMatrixSequence() -> [Matrix2x2] {
        return [.L, .L, .L, .R, .L]
    }

}

extension RationalProtocol {

    /// Returns an new insntance from random numer and denom.
    ///
    /// The denominator must not be zero.
    ///
    /// - Parameter max: The maximum value of numer and denom.
    /// - Returns: A concrete rational type is instanciated by random values.
    public static func random(max: Int32 = 1000000) -> Self {
        let numerator = Int32.random(in: 0...max)
        let denominator = Int32.random(in: 1...max)
        return Self("\(numerator)/\(denominator)")
    }

    /// Returns zero representation of sternbrocot-tree.
    public static var zero: Self {
        return Self("0/1")
    }

    /// Returns one representation of sternbrocot-tree.
    public static var identity: Self {
        return Self("1/1")
    }

    /// Returns infinity representation of sternbrocot-tree.
    public static var infinity: Self {
        return Self("1/0")
    }
    
}

// MARK: - Equatable
extension RationalProtocol {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

}

// MARK: - Comparable
extension RationalProtocol {

    public static func < (lhs: Self, rhs: Self) -> Bool {

        // If a, b, c, and d are positive, the result of a/b < c/d can represent as ad < bc.
        // 1. To remove left side devider, let both sides multiplied by b. (a < bc/d)
        // 2. To remove right side devider, let both sides multipied by d. (ad < bc)

        let a = lhs.numerator
        let b = lhs.denominator
        let c = rhs.numerator
        let d = rhs.denominator

        let ad: Int64 = Int64(a * d)
        let bc: Int64 = Int64(b * c)

        return ad < bc
    }

}

// MARK: - Hashable
extension RationalProtocol {

    public func hash(into hasher: inout Hasher) {

        // In reduced form, SBTree node's fruction must be identified in the tree.
        let x = simplified()
        hasher.combine(x.numerator)
        hasher.combine(x.denominator)
    }

}

// MARK: - Convertibles
extension RationalProtocol {

    public var description: String { "\(numerator)/\(denominator)" }

    public var float32Value: Float32 { Float32(numerator) / Float32(denominator) }

    public var float64Value: Float64 { Float64(numerator) / Float64(denominator) }

    public var doubleValue: Double { Double(numerator) / Double(denominator) }

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}
