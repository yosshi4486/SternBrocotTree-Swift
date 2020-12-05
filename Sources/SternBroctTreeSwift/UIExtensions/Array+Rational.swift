//
//  Array+Rational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/17.
//

import Foundation

public extension Array where Element : RationalOrderable {

    /// Returns a rational for new appending item.
    ///
    /// This method should be called before appending actual item to any database or table.
    func rationalForAppending() throws -> Element.ConcreteRational? {

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
    func rationalForInserting(between above: Element, and bellow: Element, numberOfItems: Int = 1) throws -> [Element.ConcreteRational] {

        var rationals: [Element.ConcreteRational] = []
        var left: Element.ConcreteRational = above.rational

        for _ in 0..<numberOfItems {
            left = try intermediate(left: left, right: bellow.rational)
            rationals.append(left)
        }

        return rationals
    }

    /// Normalize rationals.
    ///
    /// - Note:
    /// TableViewのような構造において、insertせずに最初から最後までappendだけ実行していた場合のorderはRRRRRR...のシークエンスとなる。
    /// その状態を「正規形」と定義して正規化をすれば、分子を1づつ増やしていくだけの処理と等価になるため計算量をかなり削減できる。
    mutating func normalize() {

        for i in 0..<count {
            // The denominator is always one, zero denominator error is never thrown.
            self[i].rational = try! Element.ConcreteRational(numerator: Int32(i + 1), denominator: 1)
        }

    }

}
