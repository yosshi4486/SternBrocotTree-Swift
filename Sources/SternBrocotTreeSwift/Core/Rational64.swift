//
//  Rational64.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A rational type for value semantics.
public struct Rational64 : MutableSignedRational {

    public typealias Number = Int64

    /// The numerator of the rational number.
    public var numerator: Int64

    /// The denominator of the rational number.
    public var denominator: Int64

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

    public init(numerator: Int64, denominator: Int64) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int64(splited[0])!
        let denominator = Int64(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int64, _ denominator: Int64) {
        self.numerator = numerator
        self.denominator = denominator
    }

}

extension Rational64 : SBTreeNode { }
