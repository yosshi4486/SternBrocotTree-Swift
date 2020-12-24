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


}
