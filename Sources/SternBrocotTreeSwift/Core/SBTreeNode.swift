//
//  SBTreeNode.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

/// A type of Stern Brocot Tree Node.
public protocol SBTreeNode {

    /// Returns identity representation of sternbrocot-tree.
    static var identity: Self { get }

    /// Returns the rational representation of stern brocot tree node.
    var rationalRepresentation: Rational { get }

}

extension SBTreeNode where Self : Fraction {

    /// Returns one representation of sternbrocot-tree.
    public static var identity: Self {
        return Self("1/1")
    }

    /// Returns infinity representation of sternbrocot-tree.
    public static var infinity: Self {
        return Self("1/0")
    }
    
}
