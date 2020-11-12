//
//  Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// A rational number used in sbtree terms.
struct Rational {

    /// The numerator of the rational number.
    var numerator: Int32

    /// The denominator of the rational number.
    var denominator: Int32

    init(numerator: Int32, denominator: Int32) {
        self.numerator = numerator
        self.denominator = denominator
    }

    // In some cases, initialized by string is more readable in terms of use.
    init?(fraction: String) {

        let splited = fraction.split(separator: "/")

        guard splited.count == 2, let numerator = Int32(splited[0]), let denominator = Int32(splited[1]) else {
            return nil
        }

        self.numerator = numerator
        self.denominator = denominator
    }


    // I don't know why the form is used to comparison although I know it is used in `adjacent`.
    func compare(to other: Rational) -> Int32 {

        // Two fractions r=a/b and s=c/d in reduced form are adjacent ⇄ ad - bc = ±1.
        let aTimesD: Int64 = Int64(self.numerator * other.denominator)
        let bTimesC: Int64 = Int64(self.denominator * other.numerator)

        return  (aTimesD > bTimesC).intValue - (aTimesD < bTimesC).intValue
    }

    /// Returns a new simplified rational.
    ///
    /// Returns new value when the numerator and the denominator have common devider except for ± 1,
    ///
    ///     let new = Rational(fraction: "3/9").simplified()
    ///     // new.description is 1/3.
    ///
    /// otherwise always returns nil.
    ///
    ///     let new = Rational(fraction: "3/10").simplified()
    ///     // new is nil.
    func simplified() -> Rational? {

        let common = gcd(numerator, denominator)

        let canSimplify = common != 1 && common != -1
        guard canSimplify else { return nil }

        var numerator = self.numerator
        var denominator = self.denominator

        // tricky: avoid overflow from (INT32_MIN / -1)
        if common != -1 || (numerator != Int32.min && denominator != Int32.min) {
            numerator /= common
            denominator /= common
        }

        // prevent negative denominator, but do not negate the smallest value that would produce overflow
        if denominator < 0 && numerator != Int32.min && denominator != Int32.min {
            numerator *= -1
            denominator *= -1
        }

        return Rational(numerator: numerator, denominator: denominator)
    }

    /// Returns a mediant from two fractions.
    static func mediant(left: Rational, right: Rational) -> Rational {
        Rational(
            numerator: left.numerator + right.numerator,
            denominator: left.denominator + right.denominator
        )
    }


    /// The low root node of SBTree. 0/1.
    static var rootLow: Rational { Rational(fraction: "0/1")! }


    /// The low high node of SBTree. 1/0.
    static var rootHigh: Rational { Rational(fraction: "1/0")! }

}

extension Rational : Equatable {

    static func == (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.numerator == rhs.numerator && lhs.denominator == rhs.denominator
    }

}

extension Rational : Comparable {

    static func < (lhs: Rational, rhs: Rational) -> Bool {
        return lhs.compare(to: rhs) < 0
    }

}

private extension Bool {

    var intValue: Int32 { self == true ? 1 : 0 }

}

extension Rational : CustomStringConvertible {

    var description: String { "\(numerator)/\(denominator)" }

}


extension Rational {

    var floatingValue: Float64 { Float64(numerator) / Float64(denominator) }

}
