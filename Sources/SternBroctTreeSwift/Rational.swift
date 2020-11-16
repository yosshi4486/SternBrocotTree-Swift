//
//  Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// A rational number used in sbtree terms.
public struct Rational {

    /// The numerator of the rational number.
    public var numerator: Int32


    /// The denominator of the rational number.
    public var denominator: Int32


    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    /// - Throws: An initizalization error.
    public init(numerator: Int32, denominator: Int32) throws {

        guard denominator != 0 else {
            throw InitializationError.zeroDinominator
        }

        self.numerator = numerator
        self.denominator = denominator
    }


    /// Creates an instance initizalized by the given string value splited by `/` separator.
    ///
    /// In some cases, Initialized by string literal is more readable in terms of use.
    ///
    /// - Parameter fraction: The string value represents a fruction.
    /// - Throws: An initizalization error
    public init?(fraction: String) throws {

        let splited = fraction.split(separator: "/")

        guard splited.count == 2, let numerator = Int32(splited[0]), let denominator = Int32(splited[1]) else {
            return nil
        }

        try self.init(numerator: numerator, denominator: denominator)
    }


    // Ignore zero denominator error
    private init(_ numerator: Int32, _ denominator: Int32) {
        self.numerator = numerator
        self.denominator = denominator
    }


    // Ignore zero denominator error
    private init(_ fraction: String) {

        let splited = fraction.split(separator: "/")
        let numerator = Int32(splited[0])
        let denominator = Int32(splited[1])

        self.init(numerator!, denominator!)
    }

    /// Returns a value wether this value can simplify or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    var canSimplify: Bool {
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

        return Rational(numerator, denominator)
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


    /// An arithmetic error of rational.
    public enum ArithmeticError : LocalizedError {

        case outOfRange

        public var errorDescription: String? {
            switch self {
            case .outOfRange:
                return "intermediate value overflow in rational addition"
            }
        }

    }


    /// Returns the sum of this value and the given value.
    /// 
    /// - Parameter other: The value to add to this value.
    /// - Throws: An AddingError may be thrown.
    /// - Returns: A rational that is added.
    ///
    /// - TODO: I find that this method doesn't simplify the result when it doesn't caluse overflow internally.
    public func adding(to other: Rational) throws -> Rational {

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
            // 2. If they can simplify, do it. If not, throw outOfRange(overflow) error.
            // 3. Continue the steps to resolve overflow completely.
            if isROverflowed || isSOverflowed || isNumeratorOverflowed || isDenominatorOverflowed {

                // overflow in intermediate value
                if !x.canSimplify && !y.canSimplify {

                    // neither fraction could reduce, cannot proceed
                    // (me): I don't understand how to reproduce this error now.
                    throw ArithmeticError.outOfRange
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }

        }

        return Rational(numerator, denominator)
    }


    /// Returns the defference obtained by subtracting the given value from this value.
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is subtracted.
    public func subtracting(_ other: Rational) throws -> Rational {
        try adding(to: other.negative)
    }


    /// Returns the product of this value and the given value.
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is multiplied.
    ///
    /// - TODO: I find that this method doesn't simplify the result when it doesn't caluse overflow internally.
    public func multiplied(by other: Rational) throws -> Rational {

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
                    // (me): I don't understand how to reproduce this error now.
                    throw ArithmeticError.outOfRange
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }
        }

        return Rational(numerator, denominator)
    }


    /// Returns the quatient obtained by dividing this value by the given value.
    ///
    /// - Parameter other: The value to divide this value by.
    /// - Throws: An AddingError may be thrown.
    /// - Returns: A rational that is devided.
    public func divided(by other: Rational) throws -> Rational {

        var y = other

        swap(&y.numerator, &y.denominator)

        return try multiplied(by: y)
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

    
    /// Returns a mediant from two fractions.
    public static func mediant(left: Rational, right: Rational) -> Rational {
        Rational(left.numerator + right.numerator, left.denominator + right.denominator)
    }


    /// The low root node of SBTree. 0/1.
    public static var rootLow: Rational { Rational("0/1") }


    /// The low high node of SBTree. 1/0.
    public static var rootHigh: Rational { Rational("1/0") }

}

extension Rational : Equatable {

    public static func == (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

}

extension Rational : Comparable {

    public static func < (lhs: Rational, rhs: Rational) -> Bool {

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

extension Rational : Hashable {

    public func hash(into hasher: inout Hasher) {

        // In reduced form, SBTree node's fruction must be identified in the tree.
        let x = simplified()
        hasher.combine(x.numerator)
        hasher.combine(x.denominator)
    }

}

extension Rational : CustomStringConvertible {

    public var description: String { "\(numerator)/\(denominator)" }

}

extension Rational : CustomFloatConvertible {
    
    public var floatValue: Float64 { Float64(numerator) / Float64(denominator) }

}

extension Rational {

    enum InitializationError : LocalizedError {

        case zeroDinominator

        var errorDescription: String? {

            switch self {
            case .zeroDinominator:
                return "Fraction cannot have zero denominator."
            }
        }
    }

}
