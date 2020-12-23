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


    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    /// - Throws: An initizalization error.
    public init(numerator: Int32, denominator: Int32) throws {

        guard denominator != 0 else {
            throw RationalError<Self>.zeroDenominator
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


    /// Create an instance by the given string vlaue splited by '/' separator with ignoring zero denominator error.
    ///
    /// In an `intermediate` operation, `1/0`, that is illigal value in math is used to represent an infinity node of SBTree.
    /// This `init` is required for the situation.
    ///
    /// - Parameter fractionWithNodeError:  The string value represents a fruction.
    public init(fractionWithNoError: String) {

        let splited = fractionWithNoError.split(separator: "/")
        let numerator = Int32(splited[0])
        let denominator = Int32(splited[1])

        self.init(numerator!, denominator!)
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

    /// Returns the sum of this value and the given value **in simplified form**.
    /// 
    /// - Parameter other: The value to add to this value.
    /// - Throws: An AddingError may be thrown.
    /// - Returns: A rational that is added.
    public func adding(to other: Rational) throws -> Rational {

        var x = self
        var y = other
        var xNumeratorYDenominator, yNumeratorYDenominator, numerator, denominator: Int32!
        var isROverflowed, isSOverflowed, isNumeratorOverflowed, isDenominatorOverflowed: Bool!

        // Question: I know devide by GCD only take one step to reach simple fraction.
        // Should it run loop? or only once?
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
                    throw RationalError.overflow(lhs: self, rhs: other, operation: #function)
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }

        }

        return Rational(numerator, denominator).simplified()
    }


    /// Returns the defference obtained by subtracting the given value from this value **in simplified form**.
    ///
    /// - Parameter other: The value to subtract from this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is subtracted.
    public func subtracting(_ other: Rational) throws -> Rational {
        try adding(to: other.negative)
    }


    /// Returns the product of this value and the given value **in simplified form**.
    ///
    /// - Parameter other: The value to multiply by this value.
    /// - Throws: An AddingError may be thrown
    /// - Returns: A rational that is multiplied.
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
                    throw RationalError.overflow(lhs: self, rhs: other, operation: #function)
                }

                x.simplify()
                y.simplify()

                // the fraction(s) reduced, good for one more retry
                retry = true
            } else {
                retry = false
            }
        }

        return Rational(numerator, denominator).simplified()
    }


    /// Returns the quatient obtained by dividing this value by the given value **in simplified form**.
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
    public static func mediant(left: Rational, right: Rational) throws -> Rational {

        let (numeratorAddingResult, numeratorAddingOverflow) = left.numerator.addingReportingOverflow(right.numerator)
        let (denominatorAddingResult, denominatorAddingOverflow) = left.denominator.addingReportingOverflow(right.denominator)

        if numeratorAddingOverflow || denominatorAddingOverflow {
            throw RationalError.overflow(lhs: left, rhs: right, operation: #function)
        }

        return Rational(numeratorAddingResult,denominatorAddingResult)
    }

}

extension Rational : ReferenceConvertible {

    public func _bridgeToObjectiveC() -> NSRational {
        return NSRational(rational: self)
    }

    public static func _forceBridgeFromObjectiveC(_ source: NSRational, result: inout Rational?) {
        result = source.rational
    }

    public static func _conditionallyBridgeFromObjectiveC(_ source: NSRational, result: inout Rational?) -> Bool {
        result = source.rational
        return true
    }

    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSRational?) -> Rational {
        return source!.rational
    }

    public typealias ReferenceType = NSRational
    public typealias _ObjectiveCType = NSRational

    public var debugDescription: String {
        return "debug: \(description)"
    }

}
