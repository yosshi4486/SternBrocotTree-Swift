//
//  NSFetchedResultsController+RationalOrdering.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/16.
//

import CoreData

/// A provider of order.
protocol OrderProvider {

    associatedtype Item : RationalOrdering

    associatedtype OrderType

    /// The items for ordering.
    var items: [Item] { get }


    /// Returns a rational for new appending item.
    ///
    /// Default implementation is provided.
    ///
    /// - Parameters:
    ///    - last: The last element before adding new element.
    func provideRationalForAppending() throws -> OrderType?


    /// Returns a rational for new inserting item.
    ///
    /// Default implementation is provided.
    ///
    /// - Parameters:
    ///    - adove: The element positioned adove the new inserting element.
    ///    - bellow: The element positioned bellow  the new inserting element.
    func provideRationalForInserting(between above: Item, and bellow: Item, numberOfItems: Int) throws -> [OrderType]

}

extension OrderProvider {

    func provideRationalForAppending() throws -> Rational? {

        guard let lastItemRational = items.last?.rational else {
            return nil
        }

        return try intermediate(left: lastItemRational, right: nil)
    }

    func provideRationalForInserting(between above: Item, and bellow: Item, numberOfItems: Int = 1) throws -> [Rational] {

        var rationals: [Rational] = []
        var left: Rational = above.rational

        for _ in 0..<numberOfItems {
            left = try intermediate(left: left, right: bellow.rational)
            rationals.append(left)
        }

        return rationals
    }

}
