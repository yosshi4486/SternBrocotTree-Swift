//
//  SBTreeNode.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

/// A type of Stern Brocot Tree Node.
public protocol SBTreeNode {

    /// Returns identity representation of sternbrocot-tree.
    static var identity: Self { get }

}
