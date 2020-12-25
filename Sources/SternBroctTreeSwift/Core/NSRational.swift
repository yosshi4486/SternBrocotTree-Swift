//
//  ReferencedRational.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A rational type for reference semantics. The type stores and uses value rational internally.
public final class NSRational : NSObject, NSSecureCoding, RationalProtocol {

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

    required public init(numerator: Int32, denominator: Int32) {
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
        coder.encode(rational.numerator, forKey: CodingKeys.numerator.rawValue)
        coder.encode(rational.denominator, forKey: CodingKeys.denominator.rawValue)
    }

    public required init?(coder: NSCoder) {
        let numerator = coder.decodeInt32(forKey: CodingKeys.numerator.rawValue)
        let denominator = coder.decodeInt32(forKey: CodingKeys.denominator.rawValue)
        self.rational = Rational(numerator: numerator, denominator: denominator)
    }

}
