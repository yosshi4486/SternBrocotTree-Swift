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
