//
//  MatrixSBTreeNode.swift
//  SternBrocotTreeSwift
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
public struct SBMatrix2x2 : SBTreeNode {

    public static var identity: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 0, c: 0, d: 1)
    }

    /// The metrix for generating left matrix form node.
    public static var L: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 0, c: 1, d: 1)
    }

    /// The metrix for generating right matrix form node.
    public static var R: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 1, c: 0, d: 1)
    }

    /// The value which is positioned at top left.
    public var a: Int

    /// The value which is positioned at top right.
    public var b: Int

    /// The value which is positioned at bottom left.
    public var c: Int

    /// The value which is positioned at bottom right.
    public var d: Int

    /// Returns a rational represented instance of this value.
    public var rationalRepresentation: Rational {
        return Rational(numerator: a + b, denominator: c + d)
    }

    /// Returns a determinants of this matrix.
    public var determinants: Int {
        return (a * d) - (b * c)
    }

    /// Multiplies two 2x2 matrix and produces thier product.
    ///
    /// A * B and B * A are not always equal.
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to multipy.
    ///   - rhs: The second matrix to multiply.
    public static func * (lhs: SBMatrix2x2, rhs: SBMatrix2x2) -> SBMatrix2x2 {
        return SBMatrix2x2(
            a: (lhs.a * rhs.a) + (lhs.b * rhs.c),
            b: (lhs.a * rhs.b) + (lhs.b * rhs.d),
            c: (lhs.c * rhs.a) + (lhs.d * rhs.c),
            d: (lhs.c * rhs.b) + (lhs.d * rhs.d)
        )
    }

    /// Multiplies two 2x2 matrix and stores the result in the left-hand-side variable..
    ///
    /// A * B and B * A are not always equal.
    ///
    /// - Parameters:
    ///   - lhs: The first matrix to multipy.
    ///   - rhs: The second matrix to multiply.
    public static func *= (lhs: inout SBMatrix2x2, rhs: SBMatrix2x2) {
        lhs = lhs * rhs
    }

    /// Moves to left.
    public mutating func moveLeft() {
        self *= SBMatrix2x2.L
    }

    /// Moves to right.
    public mutating func moveRight() {
        self *= SBMatrix2x2.R
    }

    /// Returns a new 2x2 matrix which positioned at left of this matrix.
    public func makeLeft() -> SBMatrix2x2 {
        return self * SBMatrix2x2.L
    }

    /// Returns a new 2x2 matrix which positioned at right of this matrix.
    public func makeRight() -> SBMatrix2x2 {
        return self * SBMatrix2x2.R
    }

}

extension SBMatrix2x2 : AdditiveArithmetic {

    public static var zero: SBMatrix2x2 {
        return SBMatrix2x2(a: 0, b: 0, c: 0, d: 0)
    }

    public static func + (lhs: SBMatrix2x2, rhs: SBMatrix2x2) -> SBMatrix2x2 {
        return SBMatrix2x2(
            a: lhs.a + rhs.a,
            b: lhs.b + rhs.b,
            c: lhs.c + rhs.c,
            d: lhs.d + rhs.d
        )
    }

    public static func - (lhs: SBMatrix2x2, rhs: SBMatrix2x2) -> SBMatrix2x2 {
        return SBMatrix2x2(
            a: lhs.a - rhs.a,
            b: lhs.b - rhs.b,
            c: lhs.c - rhs.c,
            d: lhs.d - rhs.d
        )
    }

}

extension SBMatrix2x2 : Equatable { }

extension SBMatrix2x2 : CustomStringConvertible {

    public var description: String {
        """
        \(a) \(b)
        \(c) \(d)
        """
    }

}
