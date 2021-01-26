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
    public private(set) var nodes: [Node] = []

}

extension SBTree where Node : SignedRational {

    /// Initialize by tree height. The results are stored in `self.nodes` property.
    ///
    /// - Parameters:
    ///  - height: The height of tree structure.
    ///
    /// - Complexity:
    /// O(n) where n is number of nodes in the whole tree.
    public init(height: Int) {

        // It's like a depth limited search.
        func makeNodesRecursively(depth: Int, left: Node, right: Node) {
            if depth <= height {
                let node = Node.mediant(left: left, right: right)
                makeNodesRecursively(depth: depth + 1, left: left, right: node)
                nodes.append(node)
                makeNodesRecursively(depth: depth + 1, left: node, right: right)
            }
        }

        makeNodesRecursively(depth: 1, left: .zero, right: .infinity)
    }

    /// Initialize a tree for having enough room that is able to store the given nodes.
    ///
    /// - Parameters:
    ///   - numberOfNodes: The number of nodes to store.
    ///
    /// - Complexity:
    /// O(n) where n is number of nodes in the whole tree.
    public init(numberOfNodes: Int) {
        let requiredHeight = Int(log2(Double(numberOfNodes)).rounded(.down)) + 1
        self.init(height: requiredHeight)
    }

    /// Return nodes which are located in the given depth
    ///
    /// - Parameters:
    ///  - depth: The depth of nodes.
    ///
    /// - Returns:
    /// The nodes which are located in the given depth.
    ///
    /// - Complexity:
    /// O(n) where n is number of nodes in the whole tree.
    public static func nodesInDepth(_ depth: Int) -> [Node] {
        var nodes: [Node] = []

        func makeNodesRecursively(functionDepth: Int, left: Node, right: Node) {
            if functionDepth <= depth {
                let node = Node.mediant(left: left, right: right)
                makeNodesRecursively(functionDepth: functionDepth + 1, left: left, right: node)
                if functionDepth == depth {
                    nodes.append(node)
                }
                makeNodesRecursively(functionDepth: functionDepth + 1, left: node, right: right)
            }
        }

        makeNodesRecursively(functionDepth: 1, left: .zero, right: .infinity)
        return nodes
    }

}
