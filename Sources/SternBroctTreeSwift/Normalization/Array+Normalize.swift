//
//  Array+Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/17.
//

import Foundation

public extension Array where Element : RationalUserOrderable {

    /// Normalize rationals.
    ///
    /// # Normalized Format
    ///  I have defined normalization format of rational as (n+1)/1 where n is increased by its index. ex)
    ///
    ///      rationalUserOrderableArray.normalize()
    ///      rationalUserOrderableArray[0].userOrder.description // 1/1
    ///      rationalUserOrderableArray[1].userOrder.description // 2/1
    ///      rationalUserOrderableArray[2].userOrder.description // 3/1
    ///      rationalUserOrderableArray[3].userOrder.description // 4/1
    ///      rationalUserOrderableArray[4].userOrder.description // 5/1
    ///      ...(continued)
    ///
    /// # Reason of Strategy
    /// In a structure like a table list, appending a new item to the list means executing `intermediate(left: node, right: nil)` repeatedly.
    /// It grows the format described above.
    ///
    /// It also has an advantage of computation.  Adding numer to 1 strategy is very cheap.
    mutating func normalize() {

        for i in 0..<count {
            // The denominator is always one, zero denominator error is never thrown.
            self[i].rationalUserDefinedOrder = NSRational(numerator: i + 1, denominator: 1)
        }

    }

}
