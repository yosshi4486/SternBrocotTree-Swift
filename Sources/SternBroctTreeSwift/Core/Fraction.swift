//
//  Fraction.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

public struct Fraction {

    enum Error : Swift.Error {
        case zeroDenominator
    }

    /// The numerator of the fraction.
    public var numerator: Int

    /// The denominator of the fraction.
    public var denominator: Int
    
    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Precondition:
    /// The denominator shouldn't be zero.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    public init(numerator: Int, denominator: Int) {
        precondition(denominator != 0)
        self.numerator = numerator
        self.denominator = denominator
    }

    /// Creates an instance initizalized by the given string value splited by `/` separator.
    ///
    /// In some cases, Initialized by string literal is more readable in terms of use.
    ///
    /// - Parameter stringValue: The string value represents a fruction.
    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int(splited[0])!
        let denominator = Int(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }
    
}

extension Fraction : Comparable {

    public static func < (lhs: Fraction, rhs: Fraction) -> Bool {

        // If a, b, c, and d are positive, the result of a/b < c/d can represent as ad < bc.
        // 1. To remove left side devider, let both sides multiplied by b. (a < bc/d)
        // 2. To remove right side devider, let both sides multipied by d. (ad < bc)

        let a = lhs.numerator
        let b = lhs.denominator
        let c = rhs.numerator
        let d = rhs.denominator

        let ad = a * d
        let bc = b * c

        return ad < bc
    }

}

extension Fraction : CustomStringConvertible {

    public var description: String {
        return "\(numerator)/\(denominator)"
    }

}
