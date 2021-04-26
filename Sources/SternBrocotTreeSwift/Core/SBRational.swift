//
//  ReferencedRational.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// A rational type for reference semantics. The type stores and uses value rational internally.
public final class SBRational : NSObject, NSSecureCoding, SignedRational, SBTreeNode, Codable {

    public typealias Number = Int

    private var rational: Rational

    public var rationalRepresentation: Rational {
        return self.rational
    }

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

    /*
     A RationalProtocol(fractionWithNoError:) is also usefull in compatibility of Rational and SBRational.
     */

    public func reduced() -> Self {
        let result = rational.reduced()
        return Self(result.description)
    }

    public func reduce() {
        rational.reduce()
    }

    public func addingReportingOverflow(_ other: SBRational) -> (partialValue: SBRational, overflow: Bool) {
        let (partialValue, overflow) = rational.addingReportingOverflow(other.rational)
        return (SBRational(rational: partialValue), overflow)
    }

    public func subtractingReportingOverflow(_ other: SBRational) -> (partialValue: SBRational, overflow: Bool) {
        let (partialValue, overflow) = rational.subtractingReportingOverflow(other.rational)
        return (SBRational(rational: partialValue), overflow)
    }

    public func multipliedReportingOverflow(by other: SBRational) -> (partialValue: SBRational, overflow: Bool) {
        let (partialValue, overflow) = rational.multipliedReportingOverflow(by: other.rational)
        return (SBRational(rational: partialValue), overflow)
    }

    public func dividedReportingOverflow(by other: SBRational) -> (partialValue: SBRational, overflow: Bool) {
        let (partialValue, overflow) = rational.dividedReportingOverflow(by: other.rational)
        return (SBRational(rational: partialValue), overflow)
    }

    public func negate() {
        if numerator == Int.min {
            let reduced = self.reduced()

            // check again
            if reduced.numerator == Int.min {

                // denominator can't be MIN too or fraction would have previosly simplifed to 1/1.
                self.rational = Rational(numerator: reduced.numerator, denominator: reduced.denominator * -1)
            }
        }
        self.rational = Rational(numerator: numerator * -1, denominator: denominator)
    }


    // MARK: - NSObject Protocol

    public override var description: String {
        return rational.description
    }

    public override func isEqual(_ object: Any?) -> Bool {

        guard let otherReferenceRational = object as? SBRational else {
            return false
        }

        return self.rational == otherReferenceRational.rational
    }

    public override var hash: Int {
        return rational.hashValue
    }

    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case numerator
        case denominator
    }

    // MARK: - NSSecureCoding

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

    // MARK: - Codable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rational.numerator, forKey: CodingKeys.numerator)
        try container.encode(rational.denominator, forKey: CodingKeys.denominator)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let numerator = try container.decode(Int.self, forKey: CodingKeys.numerator)
        let denominator = try container.decode(Int.self, forKey: CodingKeys.denominator)
        self.rational = Rational(numerator: numerator, denominator: denominator)
    }

}
