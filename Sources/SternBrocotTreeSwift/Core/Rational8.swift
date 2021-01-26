//
//  Rational8.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A rational type for value semantics.
public struct Rational8 : MutableSignedRational {

    public typealias Number = Int8

    /// The numerator of the rational number.
    public var numerator: Int8

    /// The denominator of the rational number.
    public var denominator: Int8

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

    public init(numerator: Int8, denominator: Int8) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int8(splited[0])!
        let denominator = Int8(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int8, _ denominator: Int8) {
        self.numerator = numerator
        self.denominator = denominator
    }

}

extension Rational8 : SBTreeNode { }
