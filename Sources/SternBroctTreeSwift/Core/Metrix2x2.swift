//
//  MatrixSBTreeNode.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/24.
//

import Foundation

/// A 2x2 matrix.
///
/// The matrix has 2x2 elements.
///
///     a b
///     c d
///
public struct Matrix2x2 {

    /// The value which is positioned at top left.
    var a: Int32

    /// The value which is positioned at top right.
    var b: Int32

    /// The value which is positioned at bottom left.
    var c: Int32

    /// The value which is positioned at bottom right.
    var d: Int32

    /// Multiplies two 2x2 matrix and produces thier product.
    ///
    /// A * B and B * A are not always equal.
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to multipy.
    ///   - rhs: The second matrix to multiply.
    public static func * (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        return Matrix2x2(
            a: (lhs.a * rhs.a) + (lhs.b * rhs.c),
            b: (lhs.a * rhs.b) + (lhs.b * rhs.d),
            c: (lhs.c * rhs.a) + (lhs.d * rhs.c),
            d: (lhs.c * rhs.b) + (lhs.d * rhs.d)
        )
    }

}

extension Matrix2x2 : AdditiveArithmetic {

    public static var zero: Matrix2x2 {
        return Matrix2x2(a: 0, b: 0, c: 0, d: 0)
    }

    public static func + (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        return Matrix2x2(
            a: lhs.a + rhs.a,
            b: lhs.b + rhs.b,
            c: lhs.c + rhs.c,
            d: lhs.d + rhs.d
        )
    }

    public static func - (lhs: Matrix2x2, rhs: Matrix2x2) -> Matrix2x2 {
        return Matrix2x2(
            a: lhs.a - rhs.a,
            b: lhs.b - rhs.b,
            c: lhs.c - rhs.c,
            d: lhs.d - rhs.d
        )
    }

}

