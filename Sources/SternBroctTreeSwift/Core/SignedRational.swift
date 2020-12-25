//
//  SignedRational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

public protocol SignedRational : Fraction where Number : SignedInteger & FixedWidthInteger {

    /// Returns a mediant from two fractions.
    static func mediant(left: Self, right: Self) throws -> Self

    /// Returns a boolean value whether this and the other are adjacent.
    ///
    /// - Parameter other: The other concrete rational to determine adjacent.
    /// - Returns: The two values are adjacent or not.
    func isAdjacent(to other: Self) -> Bool

    /// Returns an array of R or L sequence which are backwardeded from this rational.
    func backwardingMatrixSequence() -> [Matrix2x2]

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

}

/// Default implementation for SignedRational.
extension SignedRational {

    /// Returns a value wether this value can simplify or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    public var canSimplify: Bool {
        let commonFactor = gcd(numerator, denominator)
        return commonFactor != 1 && commonFactor != -1
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

        // Start from R.
        var mixPartSequence: [Number] = []
        var continueFraction = self
        while continueFraction.numerator > 1 || continueFraction.denominator > 1 {
            if continueFraction.numerator == 2 && continueFraction.denominator == 1 {
                mixPartSequence.append(1)
                break
            } else {
                mixPartSequence.append(continueFraction.mixedPart)
            }
            continueFraction = Self(numerator: continueFraction.denominator, denominator: continueFraction.mixedRemainder)
        }

        let box: [[Matrix2x2]] = mixPartSequence.enumerated()
            .compactMap({ index, value in
                guard value > 0 else {
                    return nil
                }

                if (index % 2 == 0) || index == 0 {
                    return Array(repeating: Matrix2x2.R, count: Int(value))
                } else {
                    return Array(repeating: Matrix2x2.L, count: Int(value))
                }
            })

        return box.flatMap({ $0 })
    }

}

/// Default implementation for SBTreeNode.
extension SignedRational {

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
    public var total: Number {
        return numerator + denominator
    }

    /// Returns the interger value of mixed rational.
    public var mixedPart: Number {
        return numerator / denominator
    }

    /// Returns the numerator of mixed rational.
    public var mixedRemainder: Number {
        return numerator % denominator
    }

}

/// Default implementation for Equtable.
extension SignedRational {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

}

/// Default implementation for Comparable.
extension SignedRational {

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
extension SignedRational {

    public func hash(into hasher: inout Hasher) {

        // In reduced form, SBTree node's fruction must be identified in the tree.
        let x = simplified()
        hasher.combine(x.numerator)
        hasher.combine(x.denominator)
    }

}

/// Default implementation for Convertibles.
extension SignedRational {

    public var description: String { "\(numerator)/\(denominator)" }

    public var float32Value: Float32 { Float32(numerator) / Float32(denominator) }

    public var float64Value: Float64 { Float64(numerator) / Float64(denominator) }

    public var doubleValue: Double { Double(numerator) / Double(denominator) }

}

/// Default implementation for SignedNumeric.
extension SignedRational where Magnitude == Double, IntegerLiteralType == Number {

    public static var zero: Self {
        return Self("0/1")
    }

    public var magnitude: Double {
        return abs(Double(numerator)/Double(denominator))
    }

    public init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(numerator: Number(source), denominator: 1)
    }

    public init(integerLiteral value: Number) {
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

extension SignedRational {


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
