//
//  RationalProtocol.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A protocol that represents fraction.
///
/// Rational is number that can represent it as ratio of two integer values.
public protocol Fraction : SBTreeNode, SignedNumeric, Comparable, Hashable, CustomFloatConvertible, CustomDoubleConvertible, CustomDecimalConvertible {

    associatedtype Number : Numeric

    /// The denominator of the rational number.
    var denominator: Number { get set }

    /// The numerator of the rational number.
    var numerator: Number { get set }

    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Precondition:
    /// The denominator must not be zero.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    init(numerator: Number, denominator: Number)

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
    ///- Complexity: O(log n) where n is digits of given `denominator`.
    ///
    /// - Note:
    /// `Reduce` is term used to reduce numerics by gcm, but  `simplified` execute sign inversion of the numerator and the denominator in addition.
    func simplified() -> Self

    /// Returns the sum of this value and the given value, along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameter other: The value to add to this value.
    /// - Returns:
    /// A tuple containing the result of the addition along with a Boolean value indicating whether overflow occurred.
    /// If the overflow component is false, the partialValue component contains the entire sum.
    /// If the overflow component is true, an overflow occurred and the partialValue component contains the truncated sum of this value and rhs.
    func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool)

    /// Returns the difference obtained by subtracting the given value from this value, along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Returns: A tuple containing the result of the subtraction along with a Boolean value indicating whether overflow occurred.
    ///  If the overflow component is false, the partialValue component contains the entire difference.
    ///  If the overflow component is true, an overflow occurred and the partialValue component contains the truncated result of rhs subtracted from this value.
    func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool)

    /// Returns the product of this value and the given value, along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Returns: A tuple containing the result of the subtraction along with a Boolean value indicating whether overflow occurred.
    ///  If the overflow component is false, the partialValue component contains the entire difference.
    ///  If the overflow component is true, an overflow occurred and the partialValue component contains the truncated result of rhs subtracted from this value.
    func multipliedReportingOverflow(by other: Self) -> (partialValue: Self, overflow: Bool)

    /// Returns the quotient obtained by dividing this value by the given value, along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameter other: The value to divide this value by.
    /// - Returns: A tuple containing the result of the subtraction along with a Boolean value indicating whether overflow occurred.
    ///  If the overflow component is false, the partialValue component contains the entire difference.
    ///  If the overflow component is true, an overflow occurred and the partialValue component contains the truncated result of rhs subtracted from this value.
    func dividedReportingOverflow(by other: Self) -> (partialValue: Self, overflow: Bool)

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

/// Default implementation for SBTreeNode.
extension Fraction where Number == Int32 {

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
    public var simplicity: Self {
        let ab = Int64(numerator * denominator)
        return Self("1/\(ab)")
    }

    /// Returns total of a rational.
    ///
    /// if **r=a/b** is in reduced form, define the total of r to be **t(r) ≡ a+b**.
    public var total: Int32 {
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

    /// Returns the interger value of mixed rational.
    public var mixedPart: Number {
        return numerator / denominator
    }

}

extension Fraction {

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
    
}

/// Default implementation for Equtable.
extension Fraction where Number : SignedInteger {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

}

/// Default implementation for Comparable.
extension Fraction where Number : SignedInteger {

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

/// Default implementation for Hashable.
extension Fraction where Number : SignedInteger {

    public func hash(into hasher: inout Hasher) {

        // In reduced form, SBTree node's fruction must be identified in the tree.
        let x = simplified()
        hasher.combine(x.numerator)
        hasher.combine(x.denominator)
    }

}

/// Default implementation for Convertibles.
extension Fraction where Number : SignedInteger {

    public var description: String { "\(numerator)/\(denominator)" }

    public var float32Value: Float32 { Float32(numerator) / Float32(denominator) }

    public var float64Value: Float64 { Float64(numerator) / Float64(denominator) }

    public var doubleValue: Double { Double(numerator) / Double(denominator) }

}

extension Fraction where Number == Int8 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int16 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int32 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int64 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

/// Default implementation for SignedNumeric.
extension Fraction where Number == Int32, Magnitude == Double, IntegerLiteralType == Int32 {

    public static var zero: Self {
        return Self("0/1")
    }

    public var magnitude: Double {
        return abs(Double(numerator)/Double(denominator))
    }

    public init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(numerator: Int32(source), denominator: 1)
    }

    public init(integerLiteral value: Int32) {
        self.init(numerator: value, denominator: 1)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        let denominator = lhs.denominator * rhs.denominator
        let numerator = (lhs.numerator * rhs.denominator) + (rhs.numerator * lhs.denominator)
        return self.init(numerator: numerator, denominator: denominator)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        let denominator = lhs.denominator * rhs.denominator
        let numerator = (lhs.numerator * rhs.denominator) - (rhs.numerator * lhs.denominator)
        return self.init(numerator: numerator, denominator: denominator)
    }

    public static func * (lhs: Self, rhs: Self) -> Self {
        return self.init(numerator: lhs.numerator * rhs.numerator, denominator: lhs.denominator * rhs.denominator)
    }

    public static func *= (lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }

    /// Returns the quotient of dividing the first value by the second.
    ///
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide lhs by. rhs must not be zeo.
    public static func / (lhs: Self, rhs: Self) -> Self {
        return lhs * self.init(numerator: rhs.denominator, denominator: rhs.numerator)
    }

    /// Divides the first value by the second and stores the quotient in the left-hand-side variable
    /// - Parameters:
    ///   - lhs: The value to divide.
    ///   - rhs: The value to divide lhs by. rhs must not be zeo.
    public static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

}

