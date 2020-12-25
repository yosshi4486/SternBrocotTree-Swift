//
//  Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// A rational type for value semantics.
///
/// Rational is specialized fraction which has interger denominator and numerator.
/// On 32-bit platforms, Number is the same size as Int32, and on 64-bit platforms, Number is the same size as Int64.
public struct Rational : SignedRational {

    public typealias Number = Int

    /// The numerator of the rational number.
    public var numerator: Int

    /// The denominator of the rational number.
    public var denominator: Int

    public init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int(splited[0])!
        let denominator = Int(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int, _ denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }

    /// Returns a value wether this value can simplify or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    public var canSimplify: Bool {
        let commonFactor = gcd(numerator, denominator)
        return commonFactor != 1 && commonFactor != -1
    }

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
    public func simplified() -> Rational {

        var x = self
        x.simplify()

        return x
    }

    /// Mutate this value to a simplified rational.
    public mutating func simplify() {

        let commonFactor = gcd(numerator, denominator)

        var numerator = self.numerator
        var denominator = self.denominator

        // Tricky: avoid overflow from (INT32_MIN / -1)
        // The range of Int32 is 2147483647 ~ -2147483648. Because positive range includes zero, these ranges are
        // asymmetry, so an error will occur when trying to multiplied Int32.min by -1. It causes overflow.
        if commonFactor != -1 || (numerator != Int.min && denominator != Int.min) {
            numerator /= commonFactor
            denominator /= commonFactor
        }

        // prevent negative denominator, but do not negate the smallest value that would produce overflow
        if denominator < 0 && numerator != Int.min && denominator != Int.min {
            numerator *= -1
            denominator *= -1
        }

        self.numerator = numerator
        self.denominator = denominator
    }

    // MARK: - Arithmetic Operations

    public func addingReportingOverflow(_ other: Rational) -> (partialValue: Rational, overflow: Bool) {

        var x = self
        var y = other
        var xNumeratorYDenominator, yNumeratorYDenominator, numerator, denominator: Int!
        var isROverflowed, isSOverflowed, isNumeratorOverflowed, isDenominatorOverflowed: Bool!

        var retry = true
        while retry {

            (xNumeratorYDenominator, isROverflowed) = x.numerator.multipliedReportingOverflow(by: y.denominator)
            (yNumeratorYDenominator, isSOverflowed) = y.numerator.multipliedReportingOverflow(by: x.denominator)
            (numerator,isNumeratorOverflowed) = xNumeratorYDenominator.addingReportingOverflow(yNumeratorYDenominator)
            (denominator, isDenominatorOverflowed) = x.denominator.multipliedReportingOverflow(by: y.denominator)

            // 1. Go into a branch if r,s, numerator or denominator is overflowed.
            // 2. If they can simplify, do it. If not, throw overflow error.
            // 3. Continue the steps to resolve overflow completely.
            if isROverflowed || isSOverflowed || isNumeratorOverflowed || isDenominatorOverflowed {

                // overflow in intermediate value
                if !x.canSimplify && !y.canSimplify {

                    // neither fraction could reduce, cannot proceed
                    return (Rational(numerator, denominator), true)
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }

        }

        return (Rational(numerator, denominator).simplified(), false)

    }

    public func subtractingReportingOverflow(_ other: Rational) -> (partialValue: Rational, overflow: Bool) {
        return addingReportingOverflow(-other)
    }

    public func multipliedReportingOverflow(by other: Rational) -> (partialValue: Rational, overflow: Bool) {
        var x = self
        var y = other
        var numerator, denominator: Int!
        var isNumeratorOverflowed, isDenominatorOverflowed: Bool!

        var retry = true
        while retry {

            (numerator, isNumeratorOverflowed) = x.numerator.multipliedReportingOverflow(by: y.numerator)
            (denominator, isDenominatorOverflowed) = x.denominator.multipliedReportingOverflow(by: y.denominator)

            // 1. Go into a branch if x or y is overflowed.
            // 2. If they can simplify, do it. If not, throw outOfRange(overflow) error.
            // 3. Continue the steps to resolve overflow completely.
            if isNumeratorOverflowed || isDenominatorOverflowed {

                // overflow in intermediate value
                if !x.canSimplify && !y.canSimplify {

                    // neither fraction could reduce, cannot proceed
                    return (Rational(numerator, denominator), true)
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }
        }

        return (Rational(numerator, denominator).simplified(), false)
    }

    public func dividedReportingOverflow(by other: Rational) -> (partialValue: Rational, overflow: Bool) {
        return multipliedReportingOverflow(by: Rational(other.denominator, other.numerator))
    }

    public mutating func negate() {
        if numerator == Int.min {

            let simplified = self.simplified()

            // check again
            if simplified.numerator == Int.min {

                // denominator can't be MIN too or fraction would have previosly simplifed to 1/1.
                self = Rational(simplified.numerator, simplified.denominator * -1)
            }
        }
        self = Rational(numerator * -1, denominator)
    }

    public func backwardingMatrixSequence() -> [Matrix2x2] {

        // Start from R.
        var mixPartSequence: [Int] = []
        var continueFraction = self
        while continueFraction.numerator > 1 || continueFraction.denominator > 1 {
            if continueFraction.numerator == 2 && continueFraction.denominator == 1 {
                mixPartSequence.append(1)
                break
            } else {
                mixPartSequence.append(continueFraction.mixedPart)
            }
            continueFraction = Rational(numerator: continueFraction.denominator, denominator: continueFraction.mixedRemainder)
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

    /// Returns a mediant from two fractions.
    public static func mediant(left: Self, right: Self) throws -> Self {

        let (numeratorAddingResult, numeratorAddingOverflow) = left.numerator.addingReportingOverflow(right.numerator)
        let (denominatorAddingResult, denominatorAddingOverflow) = left.denominator.addingReportingOverflow(right.denominator)

        if numeratorAddingOverflow || denominatorAddingOverflow {
            throw RationalError.overflow(lhs: left, rhs: right)
        }

        return Self(numerator: numeratorAddingResult,denominator: denominatorAddingResult)
    }


}
