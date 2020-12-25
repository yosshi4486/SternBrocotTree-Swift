//
//  ReferencedRational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A rational type for reference semantics. The type stores and uses value rational internally.
public final class NSRational : NSObject, NSSecureCoding, SignedRational {

    public typealias Number = Int

    private var rational: Rational

    public var denominator: Int {
        get {
            return rational.denominator
        }
        set {
            rational.denominator = newValue
        }
    }

    public var numerator: Int {
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

    required public init(numerator: Int, denominator: Int) {
        self.rational = Rational(numerator: numerator, denominator: denominator)
    }

    required public init(_ stringValue: String) {
        self.rational = Rational(stringValue)
    }

    public var canSimplify: Bool {
        return rational.canSimplify
    }

    /*
     A RationalProtocol(fractionWithNoError:) is also usefull in compatibility of Rational and NSRational.
     */

    public func simplified() -> Self {
        let result = rational.simplified()
        return Self(result.description)
    }

    public func simplify() {
        rational.simplify()
    }

    public func addingReportingOverflow(_ other: NSRational) -> (partialValue: NSRational, overflow: Bool) {
        let (partialValue, overflow) = rational.addingReportingOverflow(other.rational)
        return (NSRational(rational: partialValue), overflow)
    }

    public func subtractingReportingOverflow(_ other: NSRational) -> (partialValue: NSRational, overflow: Bool) {
        let (partialValue, overflow) = rational.subtractingReportingOverflow(other.rational)
        return (NSRational(rational: partialValue), overflow)
    }

    public func multipliedReportingOverflow(by other: NSRational) -> (partialValue: NSRational, overflow: Bool) {
        let (partialValue, overflow) = rational.multipliedReportingOverflow(by: other.rational)
        return (NSRational(rational: partialValue), overflow)
    }

    public func dividedReportingOverflow(by other: NSRational) -> (partialValue: NSRational, overflow: Bool) {
        let (partialValue, overflow) = rational.dividedReportingOverflow(by: other.rational)
        return (NSRational(rational: partialValue), overflow)
    }

    public func negate() {
        if numerator == Int.min {
            let simplified = self.simplified()

            // check again
            if simplified.numerator == Int.min {

                // denominator can't be MIN too or fraction would have previosly simplifed to 1/1.
                self.rational = Rational(numerator: simplified.numerator, denominator: simplified.denominator * -1)
            }
        }
        self.rational = Rational(numerator: numerator * -1, denominator: denominator)
    }

    /// Returns a mediant from two fractions.
    public static func mediant(left: NSRational, right: NSRational) throws -> Self {

        let (numeratorAddingResult, numeratorAddingOverflow) = left.numerator.addingReportingOverflow(right.numerator)
        let (denominatorAddingResult, denominatorAddingOverflow) = left.denominator.addingReportingOverflow(right.denominator)

        if numeratorAddingOverflow || denominatorAddingOverflow {
            throw RationalError.overflow(lhs: left, rhs: right)
        }

        return Self(numerator: numeratorAddingResult,denominator: denominatorAddingResult)
    }


    // MARK: - NSObject Protocol

    public override var description: String {
        return rational.description
    }

    public override func isEqual(_ object: Any?) -> Bool {

        guard let otherReferenceRational = object as? NSRational else {
            return false
        }

        return self.rational == otherReferenceRational.rational
    }

    public override var hash: Int {
        return rational.hashValue
    }

    // MARK: - NSSecureCoding

    private enum CodingKeys: String, CodingKey {
        case numerator
        case denominator
    }

    public static var supportsSecureCoding: Bool = true

    public func encode(with coder: NSCoder) {
        coder.encode(rational.numerator as NSInteger, forKey: CodingKeys.numerator.rawValue)
        coder.encode(rational.denominator as NSInteger, forKey: CodingKeys.denominator.rawValue)
    }

    public required init?(coder: NSCoder) {
        let numerator = coder.decodeInteger(forKey: CodingKeys.numerator.rawValue)
        let denominator = coder.decodeInteger(forKey: CodingKeys.denominator.rawValue)
        self.rational = Rational(numerator: numerator, denominator: denominator)
    }

}
