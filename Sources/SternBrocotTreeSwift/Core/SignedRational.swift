//
//  SignedRational.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A type of Signed Rational.
///
/// Default implementations of AddingArithmetic and Comparable don't care overflow error. Use alternative overflow reporting methods
/// like `addingReportingOverflow(:)` if you consider about overflow.
public protocol SignedRational : Fraction, CustomFloatConvertible, CustomDoubleConvertible, CustomDecimalConvertible where Number : SignedInteger & FixedWidthInteger {

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

    /// Returns the result of comparison of this value and the given value. along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameter other: The value to compare this value with.
    /// - Returns: A tuple containing the result of the subtraction along with a Boolean value indicating whether overflow occurred.
    ///  If the overflow component is false, the partialValue component contains the entire difference.
    ///  If the overflow component is true, an overflow occurred and the partialValue component contains the truncated result of rhs subtracted from this value.
    func comparedReportingOverflow(with other: Self) -> (partialValue: RationalComparisonResult, overflow: Bool)

}

/// Default implementation for SignedRational.
extension SignedRational {

    /// Returns a value wether this value can reduce or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    public var canReduce: Bool {
        let commonFactor = gcd(numerator, denominator)
        return commonFactor != 1 && commonFactor != -1
    }

    public func comparedReportingOverflow(with other: Self) -> (partialValue: RationalComparisonResult, overflow: Bool) {
        let a = Number(numerator)
        let b = Number(denominator)
        let c = Number(other.numerator)
        let d = Number(other.denominator)

        let (ad, adOverflow) = a.multipliedReportingOverflow(by: d)
        let (bc, bcOverflow) = b.multipliedReportingOverflow(by: c)

        switch (adOverflow, bcOverflow) {
        case (true, true):
            return (RationalComparisonResult.incomparable, true)

        case (true, false):
            return (RationalComparisonResult.bigger, true)

        case (false, true):
            return (RationalComparisonResult.smaller, true)
            
        case (false, false):
            if ad == bc {
                return (RationalComparisonResult.equal, false)
            } else if ad > bc {
                return (RationalComparisonResult.bigger, false)
            } else {
                return (RationalComparisonResult.smaller, false)
            }
        }
    }

}

/// Default implementation for Comparable.
extension SignedRational {

    public static func < (lhs: Self, rhs: Self) -> Bool {

        // Reduce to common denominators, then compare numerators.
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

        // Rational should be hashed in reduced form.
        let reducedForm = reduced()
        hasher.combine(reducedForm.numerator)
        hasher.combine(reducedForm.denominator)
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

/// Default implementation for SBTreeNode.
extension SignedRational where Self : SBTreeNode {

    /// Returns a mediant from two fractions.
    public static func mediant(left: Self, right: Self) -> Self {
        let numerator = left.numerator + right.numerator
        let denominator = left.denominator + right.denominator
        return Self(numerator: numerator, denominator: denominator)
    }

    /// Retuns the result of mediant of the given left and right, along with a Boolean value indicating whether overflow occurred in the operation.
    ///
    /// - Parameters:
    ///   - left: The left value to mediant.
    ///   - right: The right value to mediant.
    public static func mediantReportingOverflow(left: Self, right: Self) -> (partialValue: Self, overflow: Bool) {
        let (numeratorAddingResult, numeratorAddingOverflow) = left.numerator.addingReportingOverflow(right.numerator)
        let (denominatorAddingResult, denominatorAddingOverflow) = left.denominator.addingReportingOverflow(right.denominator)

        if numeratorAddingOverflow || denominatorAddingOverflow {
            return (Self(numerator: numeratorAddingResult, denominator: denominatorAddingResult), true)
        }

        return (Self(numerator: numeratorAddingResult,denominator: denominatorAddingResult), false)
    }

    /// Returns an array of R or L sequence which are backwardeded from this rational.
    public func backwardingMatrixSequence() -> [SBMatrix2x2] {

        // Start from R.
        var mixPartSequence: [Number] = []
        var continueFraction = self

        while continueFraction.numerator > 1 || continueFraction.denominator > 1 {
            let mixed = continueFraction.mixed()
            let isEndIndeciesOfContinueFraction = continueFraction.numerator == 2 && continueFraction.denominator == 1
            if isEndIndeciesOfContinueFraction {
                mixPartSequence.append(1)
                break
            } else {
                mixPartSequence.append(mixed.integerPart)
            }
            continueFraction = Self(numerator: mixed.fraction.denominator,
                                    denominator: mixed.fraction.numerator)
        }

        let boxOfRLMatrixes: [[SBMatrix2x2]] = mixPartSequence.enumerated().compactMap({ index, value in
            guard value > 0 else {
                return nil
            }

            let isEven = index % 2 == 0
            if isEven || index == 0 {
                return Array(repeating: SBMatrix2x2.R, count: Int(value))
            } else {
                return Array(repeating: SBMatrix2x2.L, count: Int(value))
            }
        })

        return boxOfRLMatrixes.flatMap({ $0 })
    }

    /// Returns a boolean value whether this and the other are adjacent.
    ///
    /// - Parameter other: The other concrete rational to determine adjacent.
    /// - Returns: The two values are adjacent or not.
    public func isAdjacent(to other: Self) -> Bool {
        let (ad, adOverflow) = Number(numerator).multipliedReportingOverflow(by: Number(other.denominator))
        let (bc, bcOverflow) = Number(denominator).multipliedReportingOverflow(by: Number(other.numerator))

        if !adOverflow && !bcOverflow {
            return abs(ad - bc) == 1
        } else {
            return false
        }
    }

    /// Returns simplicity of a rational.
    ///
    /// if **r=a/b** is in reduced form, **the simplicity of r** is defined to be **L(r)≡1/ab**.
    public func simplicity() -> (partialValue: Self, overflow: Bool) {
        let (ab, overflow) = Number(numerator).multipliedReportingOverflow(by: Number(denominator))
        return (Self("1/\(ab)"), overflow)
    }

    /// Returns total of a rational.
    ///
    /// if **r=a/b** is in reduced form, define the total of r to be **t(r) ≡ a+b**.
    public var total: Number {
        return numerator + denominator
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

