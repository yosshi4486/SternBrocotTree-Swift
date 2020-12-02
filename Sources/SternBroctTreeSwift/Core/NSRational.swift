//
//  ReferencedRational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A rational type for reference semantics. The type stores and uses value rational internally.
open class NSRational : NSObject, NSSecureCoding, RationalProtocol {

    private var rational: Rational

    public var denominator: Int32 {
        get {
            return rational.denominator
        }
        set {
            rational.denominator = newValue
        }
    }

    public var numerator: Int32 {
        get {
            return rational.numerator
        }
        set {
            rational.numerator = newValue
        }
    }

    required public init(rational: Rational) {
        self.rational = rational
    }

    required public init(numerator: Int32, denominator: Int32) throws {
        self.rational = try Rational(numerator: numerator, denominator: denominator)
    }

    required public init?(fraction: String) throws {

        guard let value = try Rational(fraction: fraction) else {
            return nil
        }

        self.rational = value
    }

    public required init(fractionWithNoError: String) {
        self.rational = Rational(fractionWithNoError: fractionWithNoError)
    }

    open var canSimplify: Bool {
        return rational.canSimplify
    }

    open func simplified() -> Self {
        let result = rational.simplified()
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    open func simplify() {
        rational.simplify()
    }

    open func adding(to other: NSRational) throws -> Self {
        let result = try rational.adding(to: other.rational)
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    open func subtracting(_ other: NSRational) throws -> Self {
        let result = try rational.subtracting(other.rational)
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    open func multiplied(by other: NSRational) throws -> Self {
        let result = try rational.multiplied(by: other.rational)
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    open func divided(by other: NSRational) throws -> Self {
        let result = try rational.divided(by: other.rational)
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    public static func mediant(left: NSRational, right: NSRational) throws -> Self {
        let result = try Rational.mediant(left: left.rational, right: right.rational)
        return try! Self(numerator: result.numerator, denominator: result.denominator)
    }

    open override var description: String {
        return rational.description
    }

    open override func isEqual(_ object: Any?) -> Bool {

        guard let otherReferenceRational = object as? NSRational else {
            return false
        }

        return self.rational == otherReferenceRational.rational
    }

    public override var hash: Int {
        return rational.hashValue
    }

    // MARK: - NSCoding

    private enum CodingKeys: String, CodingKey {
        case numerator
        case denominator
    }

    public static var supportsSecureCoding: Bool = true

    public func encode(with coder: NSCoder) {
        coder.encode(rational.numerator, forKey: CodingKeys.numerator.rawValue)
        coder.encode(rational.denominator, forKey: CodingKeys.denominator.rawValue)
    }

    public required init?(coder: NSCoder) {
        let numerator = coder.decodeInt32(forKey: CodingKeys.numerator.rawValue)
        let denominator = coder.decodeInt32(forKey: CodingKeys.denominator.rawValue)

        guard let rational = try? Rational(numerator: numerator, denominator: denominator) else {
            return nil
        }

        self.rational = rational
    }

}
