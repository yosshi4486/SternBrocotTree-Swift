//
//  IntegerMatrix.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2021/02/01.
//

import Foundation

/// A type represents Integer Matrix which has elements 2x2 dimension.
public protocol IntegerMatrix2x2: AdditiveArithmetic {

    // MARK: - Initializers

    /// Creates a new empty matrix.
    init()

    /// Creates a new matrix which is filled to the given value.
    init(_ value: Int)

    /// Creates a new matrix by the given elements.
    init(a: Int, b: Int, c: Int, d: Int)

    // MARK: - Matrix Properties

    /// The element of top left.
    var a: Int { get set }

    /// The element of top right.
    var b: Int { get set }

    /// The element of bottom left.
    var c: Int { get set }

    /// The element of bottom right.
    var d: Int { get set }

    /// The determinant of the matrix.
    var determinant: Int { get }

    /// The inverse of the matrix.
    var inverse: Self { get }

    /// The transpose of the matrix.
    var transpose: Self { get }

    // MARK: - Element Access

    /// Access the element at the specified position.
    subscript(column: Int, row: Int) -> Int { get set }

}

extension IntegerMatrix2x2 {

    public static func * (lhs: Self, rhs: Self) -> Self {
        Self(
            a: (lhs.a * rhs.a) + (lhs.b * rhs.c),
            b: (lhs.a * rhs.b) + (lhs.b * rhs.d),
            c: (lhs.c * rhs.a) + (lhs.d * rhs.c),
            d: (lhs.c * rhs.b) + (lhs.d * rhs.d)
        )
    }

    public static func * (lhs: Self, rhs: Int)

}

extension IntegerMatrix2x2 {

    var determinant: Int {
        return (a * d) - (b * c)
    }

    var inverse: Self {

    }

}
