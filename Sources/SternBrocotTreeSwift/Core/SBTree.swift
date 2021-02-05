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

    public enum Error: CaseIterable, LocalizedError {
        case overflow

        public var errorDescription: String? {
            return NSLocalizedString("Overflow is occured in SBTree.", comment: "")
        }

    }

}

extension SBTree where Node : SignedRational {

    /// Initialize by tree height. The results are stored in `self.nodes` property.
    ///
    /// - Parameters:
    ///  - height: The height of tree structure.
    ///
    /// - Complexity:
    /// O(n) where n is number of nodes in the whole tree.
    ///
    /// - Throws:
    /// Error.overflow is thrown when the tree is about to over Int.man.
    public init(height: Int) throws {

        // It's like a depth limited search.
        func makeNodesRecursively(depth: Int, left: Node, right: Node) throws {
            if depth <= height {
                let (node, overflow) = Node.mediantReportingOverflow(left: left, right: right)
                guard !overflow else {
                    throw Error.overflow
                }
                try makeNodesRecursively(depth: depth + 1, left: left, right: node)
                nodes.append(node)
                try makeNodesRecursively(depth: depth + 1, left: node, right: right)
            }
        }

        try makeNodesRecursively(depth: 1, left: .zero, right: .infinity)
    }

    /// Initialize a tree for having enough room that is able to store the given nodes.
    ///
    /// - Parameters:
    ///   - numberOfNodes: The number of nodes to store.
    ///
    /// - Complexity:
    /// O(n) where n is number of nodes in the whole tree.
    ///
    /// - Throws:
    /// Error.overflow is thrown when the tree is about to over Int.man.
    public init(numberOfNodes: Int) throws {
        let requiredHeight = Int(log2(Double(numberOfNodes)).rounded(.down)) + 1
        try self.init(height: requiredHeight)
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
    ///
    /// - Throws:
    /// Error.overflow is thrown when the tree is about to over Int.man.
    public static func nodesInDepth(_ depth: Int) throws -> [Node] {
        var nodes: [Node] = []

        func makeNodesRecursively(functionDepth: Int, left: Node, right: Node) throws {
            if functionDepth <= depth {

                let (node, overflow) = Node.mediantReportingOverflow(left: left, right: right)
                guard !overflow else {
                    throw Error.overflow
                }

                try makeNodesRecursively(functionDepth: functionDepth + 1, left: left, right: node)
                if functionDepth == depth {
                    nodes.append(node)
                }
                try makeNodesRecursively(functionDepth: functionDepth + 1, left: node, right: right)
            }
        }

        try makeNodesRecursively(functionDepth: 1, left: .zero, right: .infinity)
        return nodes
    }

}
