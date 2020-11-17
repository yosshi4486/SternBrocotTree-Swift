//
//  NSFetchedResultsController+RationalOrdering.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/16.
//

import CoreData

/// A provider of order.
protocol OrderProvider {

    associatedtype Item

    associatedtype OrderType

    var items: [Item] { get }


    /// Returns a rational for new appending item.
    /// - Parameters:
    ///    - last: The last element before adding new element.
    func rationalForAppending() throws -> OrderType


    /// Returns a rational for new inserting item.
    /// - Parameters:
    ///    - adove: The element positioned the new inserting element adove.
    ///    - bellow: The element positioned  the new inserting element bellow.
    func rationalForInserting(between above: Item, and bellow: Item, numberOfItems: Int) throws -> [OrderType]

}

struct RationalOrderProvider<Item : RationalOrdering> : OrderProvider {

    typealias Item = Item

    typealias OrderType = Rational

    var items: [Item]

    func rationalForAppending() throws -> Rational {
        return try intermediate(left: items.last!.rational, right: nil)
    }

    func rationalForInserting(between above: Item, and bellow: Item, numberOfItems: Int = 1) throws -> [Rational] {

        var rationals: [Rational] = []
        var left: Rational = above.rational

        for _ in 0..<numberOfItems {
            left = try intermediate(left: left, right: bellow.rational)
            rationals.append(left)
        }

        return rationals
    }

}
