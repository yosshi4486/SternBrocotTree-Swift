//
//  RationalProtocol.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A protocol that represents fraction.
///
/// Rational is number that can represent it as ratio of two integer values.
public protocol Fraction : SBTreeNode, SignedNumeric, Comparable, Hashable, CustomFloatConvertible, CustomDoubleConvertible, CustomDecimalConvertible {

    associatedtype Number : SignedNumeric

    /// The denominator of the rational number.
    var denominator: Number { get set }

    /// The numerator of the rational number.
    var numerator: Number { get set }

    /// Creates an instance initialized by the given numerator and denominator.
    ///
    /// - Precondition:
    /// The denominator must not be zero.
    ///
    /// - Parameters:
    ///   - numerator: The value acts as numerator of this instance.
    ///   - denominator: The value acts as denominator of this instance.
    init(numerator: Number, denominator: Number)

    /// Creates an instance initizalized by the given string value splited by `/` separator.
    ///
    /// In some cases, Initialized by string literal is more readable in terms of use.
    ///
    /// - Precondition:
    /// The denominator must not be zero.
    ///
    /// - Parameter stringValue: The string value represents a fruction.
    init(_ stringValue: String)

    /// Returns a value wether this value can simplify or not.
    ///
    /// - Complexity: O(log n) where n is digits of the given `denominator`.
    var canSimplify: Bool { get }

    /// Returns a new simplified rational.
    ///
    /// Returns new value when the numerator and the denominator have common devider except for ± 1,
    ///
    ///     let new = Rational(fraction: "3/9").simplified
    ///     // new.description is 1/3.
    ///
    /// otherwise always returns self.
    ///
    ///     let new = Rational(fraction: "3/10").simplified
    ///     // new.description is 3/10.
    ///
    ///- Complexity: O(log n) where n is digits of given `denominator`.
    ///
    /// - Note:
    /// `Reduce` is term used to reduce numerics by gcm, but  `simplified` execute sign inversion of the numerator and the denominator in addition.
    func simplified() -> Self

}

extension Fraction where Number == Int {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int8 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int16 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int32 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}

extension Fraction where Number == Int64 {

    public var decimalValue: Decimal { Decimal(numerator) / Decimal(denominator) }

}
