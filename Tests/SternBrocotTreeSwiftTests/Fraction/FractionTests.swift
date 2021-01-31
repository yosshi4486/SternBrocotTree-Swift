//
//  RationalProtocolTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBrocotTreeSwift

class FractionTests: XCTestCase {

    func testAdjacent() {
        let left = Rational("2/3")
        let right = Rational("3/4")

        XCTAssertTrue(left.isAdjacent(to: right))
        XCTAssertTrue(right.isAdjacent(to: left))
    }

    func testNotAdjacent() {
        let left = Rational("2/1")
        let right = Rational("3/4")

        XCTAssertFalse(left.isAdjacent(to: right))
        XCTAssertFalse(right.isAdjacent(to: left))
    }

    func testAdjacentLeftNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational("1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational("1/2")))
        XCTAssertTrue(s.isAdjacent(to: Rational("2/3")))
        XCTAssertTrue(s.isAdjacent(to: Rational("3/4")))
    }

    func testAdjacentRightNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational("1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational("2/1")))
        XCTAssertTrue(s.isAdjacent(to: Rational("3/2")))
        XCTAssertTrue(s.isAdjacent(to: Rational("4/3")))
    }

    func testNotAdjacentLeftNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational("1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational("1/2")))
        XCTAssertFalse(s.isAdjacent(to: Rational("1/3")))
        XCTAssertFalse(s.isAdjacent(to: Rational("1/4")))
    }

    func testNotAdjacentRightNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational("1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational("2/1")))
        XCTAssertFalse(s.isAdjacent(to: Rational("3/1")))
        XCTAssertFalse(s.isAdjacent(to: Rational("4/1")))
    }

    func testSimplicity() throws {
        let r = Rational("2/3")
        XCTAssertEqual(r.simplicity, Rational("1/6"))
    }

    func testSumOfSimplicitiesForRow() throws {
        let rows: [Rational] = [
            Rational("1/3"),
            Rational("2/3"),
            Rational("3/2"),
            Rational("3/1")
        ]
        let simplicities = rows.compactMap({ $0.simplicity })
        let sum = simplicities[0]
            .addingReportingOverflow(simplicities[1]).partialValue
            .addingReportingOverflow(simplicities[2]).partialValue
            .addingReportingOverflow(simplicities[3]).partialValue

        XCTAssertEqual(sum.description, "1/1")
    }

    func testTotal() {
        let r = Rational("2/3")
        XCTAssertEqual(r.total, 5)
    }

    func testSumOfTotalForRow() throws {
        // The sum of the totals alog any row is twice a power of 3.

        let rows: [Rational] = [
            Rational("1/3"),
            Rational("2/3"),
            Rational("3/2"),
            Rational("3/1")
        ]
        let totals = rows.map({ $0.total })
        let sum = totals.reduce(0, +)
        let expected = 2 * Int(pow(3.0, 2.0))
        XCTAssertEqual(sum, expected)
    }

    func testMagnitude() {
        let f = Rational(numerator: -1, denominator: 4)
        XCTAssertEqual(f.magnitude, 0.25)
    }

    func testInitExactly() {
        let f = Rational(exactly: 10)
        XCTAssertEqual(f?.numerator, 10)
        XCTAssertEqual(f?.denominator, 1)
    }

    func testInitIntegerLiteral() {
        let f = Rational(integerLiteral: 10)
        XCTAssertEqual(f.numerator, 10)
        XCTAssertEqual(f.denominator, 1)
    }

    func testAdding() {
        let result = Rational("1/3") + Rational("1/4")
        XCTAssertEqual(result.numerator, 7)
        XCTAssertEqual(result.denominator, 12)
    }

    func testSubtracting() {
        let result = Rational("1/3") - Rational("1/4")
        XCTAssertEqual(result.numerator, 1)
        XCTAssertEqual(result.denominator, 12)
    }

    func testMultiply() {
        let result = Rational("7/3") * Rational("3/4")
        XCTAssertEqual(result.numerator, 21)
        XCTAssertEqual(result.denominator, 12)
    }

    func testMultiplyAssign() {
        var f = Rational("7/3")
        f *= Rational("3/4")
        XCTAssertEqual(f.numerator, 21)
        XCTAssertEqual(f.denominator, 12)
    }

    func testDivide() {
        let result = Rational("7/3") / Rational("3/4")
        XCTAssertEqual(result.numerator, 28)
        XCTAssertEqual(result.denominator, 9)
    }

    func testDivideAssing() {
        var f = Rational("7/3")
        f /= Rational("3/4")
        XCTAssertEqual(f.numerator, 28)
        XCTAssertEqual(f.denominator, 9)
    }

    func testNegative() {
        var f = Rational("7/3")
        f.negate()
        XCTAssertEqual(f.numerator, -7)
        XCTAssertEqual(f.denominator, 3)
    }

    func testBackwardsMatrixSequnce1() {
        let rational = Rational("3/11")
        let matrixSequence = rational.backwardingMatrixSequence()

        XCTAssertEqual(matrixSequence, [.L, .L, .L, .R, .L])
    }

    func testBackwardsMatrixSequnce2() {
        let rational = Rational("19/8")
        let matrixSequence = rational.backwardingMatrixSequence()

        XCTAssertEqual(matrixSequence, [.R, .R, .L, .L, .R, .L])
    }

    func testUnitFraction() {
        let rational = Rational("1/9")
        XCTAssertTrue(rational.isUnit)
    }

    func testNotUnitFraction() {
        let rational = Rational("2/9")
        XCTAssertFalse(rational.isUnit)
    }

    func testNotUnitFractionWhenZero() {
        let rational = Rational("0/9")
        XCTAssertFalse(rational.isUnit)
    }

    func testProperFraction() {
        let rational = Rational("1/3")
        XCTAssertTrue(rational.isProper)
    }

    func testNotProperFraction() {
        let rational = Rational("4/3")
        XCTAssertFalse(rational.isProper)
    }

    func testNotProperFractionWhenEqual() {
        let rational = Rational("3/3")
        XCTAssertFalse(rational.isProper)
    }

    func testImproperFraction() {
        let rational = Rational("3/4")
        XCTAssertTrue(rational.isImproper)
    }

    func testNotImproperFraction() {
        let rational = Rational("3/2")
        XCTAssertFalse(rational.isImproper)
    }

    func testNotImproperFractionWhenEqual() {
        let rational = Rational("3/3")
        XCTAssertFalse(rational.isImproper)
    }

    func testMixedForm() {
        let rational = Rational("7/3")
        let result = rational.mixed()
        XCTAssertEqual(result.integerPart, 2)
        XCTAssertEqual(result.fraction.description, "1/3")
    }

    func testMixedFormIntegerZero() {
        let rational = Rational("2/3")
        let result = rational.mixed()
        XCTAssertEqual(result.integerPart, 0)
        XCTAssertEqual(result.fraction.description, "2/3")
    }

}
