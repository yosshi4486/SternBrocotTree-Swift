//
//  SBTreeNode.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

/// A type of Stern Brocot Tree Node.
public protocol SBTreeNode : Comparable {

    /// Returns a mediant from two fractions.
    static func mediant(left: Self, right: Self) throws -> Self

    /// Returns a boolean value whether this and the other are adjacent.
    ///
    /// - Parameter other: The other concrete rational to determine adjacent.
    /// - Returns: The two values are adjacent or not.
    func isAdjacent(to other: Self) -> Bool

    /// Returns zero representation of sternbrocot-tree.
    static var zero: Self { get }

    /// Returns one representation of sternbrocot-tree.
    static var one: Self { get }

    /// Returns infinity representation of sternbrocot-tree.
    static var infinity: Self { get }

}
