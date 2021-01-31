//
//  SBMatrix2x2.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2021/01/31.
//

import Foundation

/// A 2x2 matrix.
///
/// The matrix has 2x2 elements.
///
///     a b
///     c d
///
/// - Remark:
/// This type is copy of Matrix2x2. My implementations is WET, which means not DRY. Please advice me If anyone notices this implementation and knows good way to bridge
/// value semantics to reference semantics without including WET code. (Code generator...?)
public final class SBMatrix2x2: NSObject, NSSecureCoding {

    /// The value which is positioned at top left.
    public var a: Int

    /// The value which is positioned at top right.
    public var b: Int

    /// The value which is positioned at bottom left.
    public var c: Int

    /// The value which is positioned at bottom right.
    public var d: Int

    init(a: Int, b: Int, c: Int, d: Int) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
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

    // MARK: - NSObject Protocol

    public override var description: String {
        return """
        \(a) \(b)
        \(c) \(d)
        """
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SBMatrix2x2 else {
            return false
        }

        return self.a == other.a && self.b == other.b && self.c == other.c && self.d == other.d
    }

    // MARK: - NSSecureCoding

    private enum CodingKeys: String, CodingKey {
        case a
        case b
        case c
        case d
    }

    public static var supportsSecureCoding: Bool = true

    public func encode(with coder: NSCoder) {
        coder.encode(a as NSInteger, forKey: CodingKeys.a.rawValue)
        coder.encode(b as NSInteger, forKey: CodingKeys.b.rawValue)
        coder.encode(c as NSInteger, forKey: CodingKeys.c.rawValue)
        coder.encode(d as NSInteger, forKey: CodingKeys.d.rawValue)
    }

    public required init?(coder: NSCoder) {
        self.a = coder.decodeInteger(forKey: CodingKeys.a.rawValue)
        self.b = coder.decodeInteger(forKey: CodingKeys.b.rawValue)
        self.c = coder.decodeInteger(forKey: CodingKeys.c.rawValue)
        self.d = coder.decodeInteger(forKey: CodingKeys.d.rawValue)
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

extension SBMatrix2x2 : SBTreeNode {

    public static var identity: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 0, c: 0, d: 1)
    }

    public var rationalRepresentation: Rational {
        return Rational(numerator: a + b, denominator: c + d)
    }

    /// The metrix for generating left matrix form node.
    public static var L: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 0, c: 1, d: 1)
    }

    /// The metrix for generating right matrix form node.
    public static var R: SBMatrix2x2 {
        return SBMatrix2x2(a: 1, b: 1, c: 0, d: 1)
    }

    /// Moves to left.
    public func moveLeft() {
        let result = self * SBMatrix2x2.L

        self.a = result.a
        self.b = result.b
        self.c = result.c
        self.d = result.d
    }

    /// Moves to right.
    public func moveRight() {
        let result = self * SBMatrix2x2.R

        self.a = result.a
        self.b = result.b
        self.c = result.c
        self.d = result.d
    }

    /// Returns a new 2x2 matrix which positioned at left of this matrix.
    public func makeLeft() -> SBMatrix2x2 {
        return self * SBMatrix2x2.L
    }

    /// Returns a new 2x2 matrix which positioned at right of this matrix.
    public func makeRight() -> SBMatrix2x2 {
        return self * SBMatrix2x2.R
    }

    /// Returns a determinants of this matrix.
    public var determinants: Int {
        return (a * d) - (b * c)
    }

}
