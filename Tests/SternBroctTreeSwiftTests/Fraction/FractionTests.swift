//
//  FractionTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBroctTreeSwift

class FractionTests: XCTestCase {

    func testDescription() {
        let f = Fraction(numerator: 1, denominator: 10)
        XCTAssertEqual(f.description, "1/10")
    }

    func testInitFromString() {
        let f = Fraction("2/3")
        XCTAssertEqual(f.numerator, 2)
        XCTAssertEqual(f.denominator, 3)
    }

    func testEqual() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/3")
        XCTAssertEqual(a, b)
    }

    func testNotEqualWhenAIsLessThanB() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/4")
        XCTAssertNotEqual(a, b)
    }

    func testNotEqualWhenAIsGreaterThanB() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/3")
        XCTAssertNotEqual(a, b)
    }

    func testAIsLessThanB() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/3")
        XCTAssertTrue(a < b)
    }

    func testAIsLessThanBFailure() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/4")
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanBFailureWhenEqual() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/4")
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanEqualB() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/3")
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBWhenEqual() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/4")
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBFailure() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/4")
        XCTAssertFalse(a <= b)
    }

    func testAIsGreaterThanB() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/4")
        XCTAssertTrue(a > b)
    }

    func testAIsGreaterThanBFailure() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/3")
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanBFailureWhenEqual() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/4")
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanEqualB() throws {
        let a = Fraction("1/3")
        let b = Fraction("1/4")
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBWhenEqual() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/4")
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBFailure() throws {
        let a = Fraction("1/4")
        let b = Fraction("1/3")
        XCTAssertFalse(a >= b)
    }

    func testMagnitude() {
        let f = Fraction(numerator: -1, denominator: 4)
        XCTAssertEqual(f.magnitude, 0.25)
    }

    func testInitExactly() {
        let f = Fraction(exactly: 10)
        XCTAssertEqual(f?.numerator, 10)
        XCTAssertEqual(f?.denominator, 1)
    }

    func testInitIntegerLiteral() {
        let f = Fraction(integerLiteral: 10)
        XCTAssertEqual(f.numerator, 10)
        XCTAssertEqual(f.denominator, 1)
    }

    func testAdding() {
        let result = Fraction("1/3") + Fraction("1/4")
        XCTAssertEqual(result.numerator, 7)
        XCTAssertEqual(result.denominator, 12)
    }

    func testSubtracting() {
        let result = Fraction("1/3") - Fraction("1/4")
        XCTAssertEqual(result.numerator, 1)
        XCTAssertEqual(result.denominator, 12)
    }

    func testMultiply() {
        let result = Fraction("7/3") * Fraction("3/4")
        XCTAssertEqual(result.numerator, 21)
        XCTAssertEqual(result.denominator, 12)
    }

    func testMultiplyAssign() {
        var f = Fraction("7/3")
        f *= Fraction("3/4")
        XCTAssertEqual(f.numerator, 21)
        XCTAssertEqual(f.denominator, 12)
    }

    func testDivide() {
        let result = Fraction("7/3") / Fraction("3/4")
        XCTAssertEqual(result.numerator, 28)
        XCTAssertEqual(result.denominator, 9)
    }

    func testDivideAssing() {
        var f = Fraction("7/3")
        f /= Fraction("3/4")
        XCTAssertEqual(f.numerator, 28)
        XCTAssertEqual(f.denominator, 9)
    }

    func testNegative() {
        var f = Fraction("7/3")
        f.negate()
        XCTAssertEqual(f.numerator, -7)
        XCTAssertEqual(f.denominator, 3)
    }

}
