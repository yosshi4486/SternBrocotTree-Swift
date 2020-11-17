//
//  Array+Rational.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/17.
//

import Foundation

public extension Array where Element : RationalOrderable {

    /// Returns a rational for new appending item.
    ///
    /// This method should be called before appending actual item to any database or table.
    func rationalForAppending() throws -> Rational? {

        guard let lastItemRational = last?.rational else {
            return nil
        }

        return try intermediate(left: lastItemRational, right: nil)
    }

    /// Returns a rational for new inserting item.
    ///
    /// Default implementation is provided.
    ///
    /// - Parameters:
    ///    - adove: The item positioned adove the new inserting element.
    ///    - bellow: The item positioned bellow  the new inserting element.
    func rationalForInserting(between above: Element, and bellow: Element, numberOfItems: Int = 1) throws -> [Rational] {

        var rationals: [Rational] = []
        var left: Rational = above.rational

        for _ in 0..<numberOfItems {
            left = try intermediate(left: left, right: bellow.rational)
            rationals.append(left)
        }

        return rationals
    }

}
