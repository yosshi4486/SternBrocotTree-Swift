//
//  RationalArithmeticTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/11/12.
//

import XCTest
@testable import SternBrocotTreeSwift

class RationalArithmeticTests: XCTestCase {

    func testCanSimplify() throws {
        let rational = Rational("3/9")
        XCTAssertTrue(rational.canSimplify)
    }

    func testCannotSimplify() throws {
        let rational = Rational("3/10")
        XCTAssertFalse(rational.canSimplify)
    }

    func testSimplified() throws {
        let rational = Rational("3/9")
        XCTAssertEqual(rational.simplified().description, "1/3")
    }

    func testSimplifiedNotChanged() throws {
        let rational = Rational("3/10")
        XCTAssertEqual(rational.simplified().description, "3/10")
    }

    func testSimplify() throws {
        var rational = Rational("3/9")
        rational.simplify()
        XCTAssertEqual(rational.description, "1/3")
    }

    func testSimplifyNotChanged() throws {
        var rational = Rational("3/10")
        rational.simplify()
        XCTAssertEqual(rational.description, "3/10")
    }


    func testAdd() throws {
        let a = Rational("1/3")
        let b = Rational("1/3")
        let result = a.addingReportingOverflow(b).partialValue

        XCTAssertEqual(result.description, "2/3")
    }

    func testMult() throws {
        let a = Rational("1/3")
        let b = Rational("1/3")
        let result = a.multipliedReportingOverflow(by: b).partialValue

        XCTAssertEqual(result.description, "1/9")
    }

    func testSub() throws {
        let a = Rational("2/3")
        let b = Rational("1/3")
        let result = a.subtractingReportingOverflow(b).partialValue

        XCTAssertEqual(result.description, "1/3")
    }

    func testDiv() throws {
        let a = Rational("2/3")
        let b = Rational("1/3")
        let result = a.dividedReportingOverflow(by: b).partialValue

        XCTAssertEqual(result.description, "2/1")
    }

    func testCompareEqual() {
        let a = Rational8("1/1")
        let b = Rational8("1/1")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .equal)
        XCTAssertFalse(result.overflow)
    }

    func testCompareBigger() {
        let a = Rational8("1/1")
        let b = Rational8("1/2")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .bigger)
        XCTAssertFalse(result.overflow)
    }

    func testCompareSmaller() {
        let a = Rational8("1/2")
        let b = Rational8("1/1")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .smaller)
        XCTAssertFalse(result.overflow)
    }

    // white box tests.
    func testCompareOverflowLeft() {
        let a = Rational8("127/1")
        let b = Rational8("1/2")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .bigger)
        XCTAssertTrue(result.overflow)
    }

    func testCompareOverflowRight() {
        let a = Rational8("1/127")
        let b = Rational8("2/1")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .smaller)
        XCTAssertTrue(result.overflow)
    }

    func testCompareOverflowBoth() {
        let a = Rational8("2/127")
        let b = Rational8("2/127")

        let result = a.comparedReportingOverflow(with: b)
        XCTAssertEqual(result.partialValue, .incomparable)
        XCTAssertTrue(result.overflow)
    }

    // This is benefit of adopting SignedNumeric. The protocol use `public init(integerLiteral value: IntegerLiteralType)` to adding integer.
    func testAddingToIntegerNumber() {
        let r = Rational8("2/3")
        let result = r + 1
        XCTAssertEqual(result.description, "5/3")
    }

    func testIntegerNumberAddingToRational() {
        let r = Rational8("2/3")
        let result = 1 + r
        XCTAssertEqual(result.description, "5/3")
    }

    func testMultiplyByIntegerNumber() {
        let r = Rational8("2/3")
        let result = r * 3
        XCTAssertEqual(result.description, "6/3")
    }

    func testIntegerNumberMultiplyByRational() {
        let r = Rational8("2/3")
        let result = 3 * r
        XCTAssertEqual(result.description, "6/3")
    }


}
