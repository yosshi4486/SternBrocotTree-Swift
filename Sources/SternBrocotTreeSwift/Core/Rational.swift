//
//  Rational.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// A rational type for value semantics.
///
/// Rational is specialized fraction which has interger denominator and numerator.
/// On 32-bit platforms, Number is the same size as Int32, and on 64-bit platforms, Number is the same size as Int64.
public struct Rational : MutableSignedRational {

    public typealias Number = Int

    /// The numerator of the rational number.
    public var numerator: Int

    /// The denominator of the rational number.
    public var denominator: Int
    
    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

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

}

extension Rational : SBTreeNode {
    
    public var rationalRepresentation: Rational {
        return self
    }

}
