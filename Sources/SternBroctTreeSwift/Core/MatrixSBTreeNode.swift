//
//  MatrixSBTreeNode.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

/// A matrix form of Stern Brocot Tree node.
///
/// The matrix has 2x2 elements.
///
///     a b
///     c d
///
public struct MatrixSBTreeNode {

    /// The value which is positioned at top left.
    var a: Int32

    /// The value which is positioned at top right.
    var b: Int32

    /// The value which is positioned at bottom left.
    var c: Int32

    /// The value which is positioned at bottom right.
    var d: Int32

}
