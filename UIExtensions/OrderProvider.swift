//
//  NSFetchedResultsController+RationalOrdering.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/16.
//

import CoreData

/// A provider of order.
public protocol OrderProvider {

    associatedtype Item : RationalOrderable

    associatedtype OrderType

    /// The items for ordering.
    var items: [Item] { get }


    /// Returns a rational for new appending item.
    ///
    /// This method should be called before appending actual item to any database or table. Default implementation is provided.
    func provideRationalForAppending() throws -> OrderType?


    /// Returns a rational for new inserting item.
    ///
    /// Default implementation is provided.
    ///
    /// - Parameters:
    ///    - adove: The item positioned adove the new inserting element.
    ///    - bellow: The item positioned bellow  the new inserting element.
    func provideRationalForInserting(between above: Item, and bellow: Item, numberOfItems: Int) throws -> [OrderType]

}

public extension OrderProvider {

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
