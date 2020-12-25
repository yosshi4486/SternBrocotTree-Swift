//
//  Rational16.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A rational type for value semantics.
public struct Rational16 : MutableSignedRational {

    public typealias Number = Int16

    /// The numerator of the rational number.
    public var numerator: Int16

    /// The denominator of the rational number.
    public var denominator: Int16

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

    public init(numerator: Int16, denominator: Int16) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public init(_ stringValue: String) {
        let splited = stringValue.split(separator: "/")

        let numerator = Int16(splited[0])!
        let denominator = Int16(splited[1])!

        self.init(numerator: numerator, denominator: denominator)
    }

    // Ignore zero denominator error
    private init(_ numerator: Int16, _ denominator: Int16) {
        self.numerator = numerator
        self.denominator = denominator
    }

    public func backwardingMatrixSequence() -> [Matrix2x2] {

        // Start from R.
        var mixPartSequence: [Int16] = []
        var continueFraction = self
        while continueFraction.numerator > 1 || continueFraction.denominator > 1 {
            if continueFraction.numerator == 2 && continueFraction.denominator == 1 {
                mixPartSequence.append(1)
                break
            } else {
                mixPartSequence.append(continueFraction.mixedPart)
            }
            continueFraction = Rational16(numerator: continueFraction.denominator, denominator: continueFraction.mixedRemainder)
        }

        let box: [[Matrix2x2]] = mixPartSequence.enumerated()
            .compactMap({ index, value in
                guard value > 0 else {
                    return nil
                }

                if (index % 2 == 0) || index == 0 {
                    return Array(repeating: Matrix2x2.R, count: Int(value))
                } else {
                    return Array(repeating: Matrix2x2.L, count: Int(value))
                }
            })

        return box.flatMap({ $0 })
    }

}

