//
//  MathHelpers.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/12.
//

import Foundation

/// Returns a greatest common divider(gcd) for the given factors.
///
/// - Complexity: O(log n) where n is digits of the given `b`.
func gcd<Integer : SignedInteger>(_ a: Integer, _ b: Integer) -> Integer {

    var a = a
    var b = b
    var r: Integer

    // Euclidean algorithm
    // https://en.wikipedia.org/wiki/Euclidean_algorithm
    while b != 0 {
        r = a % b
        a = b
        b = r
    }

    return a
}
