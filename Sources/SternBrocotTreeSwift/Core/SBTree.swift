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

extension SBTree where Node : SignedRational {

    /// Initialize by tree height. The results are stored in `self.nodes` property.
    ///
    /// - Parameter height: The height of tree structure.
    init(height: Int) {

        // It's like a depth limited search.
        func makeNodesRecursively(depth: Int, left: Node, right: Node) {
            if depth > 0 {
                let node = Node.mediant(left: left, right: right)
                makeNodesRecursively(depth: depth - 1, left: left, right: node)
                nodes.append(node)
                makeNodesRecursively(depth: depth - 1, left: node, right: right)
            }
        }

        makeNodesRecursively(depth: height, left: .zero, right: .infinity)
    }

}
