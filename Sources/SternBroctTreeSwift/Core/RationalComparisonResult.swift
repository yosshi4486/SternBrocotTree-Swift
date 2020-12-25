//
//  RationalComparisonResult.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/25.
//

import Foundation

/// A type represent a result of rational comparison.
public enum RationalComparisonResult : Int {

    /// The values are equal.
    case equal

    /// The lhs is bigger than the other.
    case bigger

    /// The lhs is smaller than the other.
    case smaller

    /// Both of values are overflow.
    case incomparable
}
