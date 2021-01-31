//
//  MutableSignedRational.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

public protocol MutableSignedRational : SignedRational {

    mutating func reduce()

}

extension MutableSignedRational {

    /// Mutate this value to a reduced rational.
    public mutating func reduce() {

        let commonFactor = gcd(numerator, denominator)

        var numerator = self.numerator
        var denominator = self.denominator

        // Tricky: avoid overflow from (INT32_MIN / -1)
        // The range of Int64 is 2147483647 ~ -2147483648. Because positive range includes zero, these ranges are
        // asymmetry, so an error will occur when trying to multiplied Int64.min by -1. It causes overflow.
        if commonFactor != -1 || (numerator != Number.min && denominator != Number.min) {
            numerator /= commonFactor
            denominator /= commonFactor
        }

        // prevent negative denominator, but do not negate the smallest value that would produce overflow
        if denominator < 0 && numerator != Number.min && denominator != Number.min {
            numerator *= -1
            denominator *= -1
        }

        self.numerator = numerator
        self.denominator = denominator
    }

    /// Returns a new reduced rational.
    ///
    /// Returns new value when the numerator and the denominator have common devider except for ± 1,
    ///
    ///     let new = Rational(fraction: "3/9").reduced
    ///     // new.description is 1/3.
    ///
    /// otherwise always returns self.
    ///
    ///     let new = Rational(fraction: "3/10").reduced
    ///     // new.description is 3/10.
    ///
    /// - Note:
    /// `Reduce` is term used to reduce numerics by gcm, but  `reduced` execute sign inversion of the numerator and the denominator in addition.
    public func reduced() -> Self {

        var x = self
        x.reduce()

        return x
    }

    // MARK: - Arithmetic Operations

    public func addingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {

        var x = self
        var y = other
        var xNumeratorYDenominator, yNumeratorYDenominator, numerator, denominator: Number!
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
                if !x.canReduce && !y.canReduce {

                    // neither fraction could reduce, cannot proceed
                    return (Self(numerator: numerator, denominator: denominator), true)
                }

                x.reduce()
                y.reduce()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }

        }

        return (Self(numerator: numerator, denominator: denominator).reduced(), false)

    }

    public func subtractingReportingOverflow(_ other: Self) -> (partialValue: Self, overflow: Bool) {
        return addingReportingOverflow(-other)
    }

    public func multipliedReportingOverflow(by other: Self) -> (partialValue: Self, overflow: Bool) {
        var x = self
        var y = other
        var numerator, denominator: Number!
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
                if !x.canReduce && !y.canReduce {

                    // neither fraction could reduce, cannot proceed
                    return (Self(numerator: numerator, denominator: denominator), true)
                }

                x.reduce()
                y.reduce()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }
        }

        return (Self(numerator: numerator, denominator: denominator).reduced(), false)
    }

    public func dividedReportingOverflow(by other: Self) -> (partialValue: Self, overflow: Bool) {
        return multipliedReportingOverflow(by: Self(numerator: other.denominator, denominator: other.numerator))
    }

    public mutating func negate() {
        if numerator == Number.min {

            let simplified = self.reduced()

            // check again
            if simplified.numerator == Number.min {

                // denominator can't be MIN too or fraction would have previosly simplifed to 1/1.
                self = Self(numerator: simplified.numerator, denominator: simplified.denominator * -1)
            }
        }
        self = Self(numerator: numerator * -1, denominator: denominator)
    }

}
