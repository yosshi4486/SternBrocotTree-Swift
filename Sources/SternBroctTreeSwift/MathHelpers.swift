//
//  MathHelpers.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/12.
//

import Foundation

/// Returns a greatest common divider(gcd) for the given factors.
func gcd(_ a: Int32, _ b: Int32) -> Int32 {

    var a = a
    var b = b
    var tmp: Int32

    while b != 0 {
        tmp = a % b
        a = b
        b = tmp
    }

    return a
}
