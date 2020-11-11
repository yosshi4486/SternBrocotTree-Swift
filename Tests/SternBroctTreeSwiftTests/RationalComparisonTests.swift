//
//  RationalComparisonTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalComparisonTests: XCTestCase {

    func testEqual() {
        let a = Rational(fraction: "1/3")
        let b = Rational(fraction: "1/3")
        XCTAssertEqual(a, b)
    }

    func testNotEqualWhenAIsLessThanB() {
        let a = Rational(fraction: "1/3")
        let b = Rational(fraction: "1/4")
        XCTAssertNotEqual(a, b)
    }

    func testNotEqualWhenAIsGreaterThanB() {
        let a = Rational(fraction: "1/4")
        let b = Rational(fraction: "1/3")
        XCTAssertNotEqual(a, b)
    }

    func testAIsLessThanB() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/3")!
        XCTAssertTrue(a < b)
    }

    func testAIsLessThanBFailure() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanBFailureWhenEqual() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/4")!
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanEqualB() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/3")!
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBWhenEqual() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/4")!
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBFailure() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!
        XCTAssertFalse(a <= b)
    }

    func testAIsGreaterThanB() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!
        XCTAssertTrue(a > b)
    }

    func testAIsGreaterThanBFailure() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/3")!
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanBFailureWhenEqual() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/4")!
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanEqualB() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBWhenEqual() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/4")!
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBFailure() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/3")!
        XCTAssertFalse(a >= b)
    }

    func testMin() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!

        let result = min(a, b)
        XCTAssertEqual(result, b)
    }

    func testMax() {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/4")!

        let result = max(a, b)
        XCTAssertEqual(result, a)
    }

}
