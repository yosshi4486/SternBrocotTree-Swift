//
//  SBTree.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2021/01/26.
//

import Foundation

/// A type of Stern Brocot Tree.
public struct SBTree<Node: SBTreeNode> {

    /// The sequence of concrete stern brocot tree nodes which are alighed left to right.
    private(set) var nodes: [Node] = []

}

extension SBTree where Node == Rational {

    /// Initialize by tree height. The results are stored in `self.nodes` property.
    ///
    /// - Parameter height: The height of tree structure.
    init(height: Int) {
        nodes = [Rational(numerator: 1, denominator: 1)]
    }

}
