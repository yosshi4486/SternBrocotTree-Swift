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
    let numerator: Int32

    /// The denominator of the rational number.
    let denominator: Int32

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

private extension Bool {

    var intValue: Int32 { self == true ? 1 : 0 }

}

extension Rational : CustomStringConvertible {

    var description: String { "\(numerator)/\(denominator)" }

}


extension Rational {

    var floatingValue: Float64 { Float64(numerator) / Float64(denominator) }

}
