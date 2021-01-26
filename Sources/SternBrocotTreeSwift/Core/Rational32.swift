//
//  Rational32.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A rational type for value semantics.
public struct Rational32 : MutableSignedRational {

    public typealias Number = Int32

    /// The numerator of the rational number.
    public var numerator: Int32

    /// The denominator of the rational number.
    public var denominator: Int32

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

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
        
}

extension Rational32 : SBTreeNode {

    public var rationalRepresentation: Rational {
        return Rational(numerator: Int(numerator), denominator: Int(denominator))
    }

}
