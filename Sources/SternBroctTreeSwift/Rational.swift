//
//  Rational.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/11.
//

import Foundation

/// A rational number used in sbtree terms.
struct Rational {

    /// The numerator of the rational number.
    let numerator: Int32

    /// The denominator of the rational number.
    let denominator: Int32

    // I don't know why the form is used to comparison although I know it is used in `adjacent`.
    func compare(to other: Rational) -> Int32 {

        let cross1: Int64 = Int64(self.numerator * other.denominator)
        let cross2: Int64 = Int64(self.denominator * other.numerator)

        return (cross1 > cross2).intValue - (cross1 < cross2).intValue
    }

}

private extension Bool {

    var intValue: Int32 {
        return self == true ? 1 : 0
    }

}

extension Rational : CustomStringConvertible {

    var description: String {
        return "\(numerator)/\(denominator)"
    }

}


extension Rational {

    var floatValue: Float64 {
        return Float64(numerator) / Float64(denominator)
    }

}
