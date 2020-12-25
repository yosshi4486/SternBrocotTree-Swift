//
//  Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// A rational type for value semantics.
public struct Rational : RationalProtocol {
    
    /// The numerator of the rational number.
    public var numerator: Int32

    /// The denominator of the rational number.
    public var denominator: Int32

    public init(numerator: Int32, denominator: Int32) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {

        let splited = stringValue.split(separator: "/")

        let numerator = Int32(splited[0])!
        let denominator = Int32(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int32, _ denominator: Int32) {
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
        if commonFactor != -1 || (numerator != Int32.min && denominator != Int32.min) {
            numerator /= commonFactor
            denominator /= commonFactor
        }

        // prevent negative denominator, but do not negate the smallest value that would produce overflow
        if denominator < 0 && numerator != Int32.min && denominator != Int32.min {
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
        var xNumeratorYDenominator, yNumeratorYDenominator, numerator, denominator: Int32!
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
        var numerator, denominator: Int32!
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

    private var negative: Rational {

        if numerator == Int32.min {

            let simplified = self.simplified()

            // check again
            if simplified.numerator == Int32.min {

                // denominator can't be MIN too or fraction would have previosly simplifed to 1/1.
                return Rational(simplified.numerator, simplified.denominator * -1)
            }

        }

        return Rational(numerator * -1, denominator)
    }

}
