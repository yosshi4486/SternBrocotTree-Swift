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

    func testNotEqual() {
        let a = Rational(fraction: "1/3")
        let b = Rational(fraction: "1/4")
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

    func testAIsLessThanEqualB() {
        let a = Rational(fraction: "1/4")!
        let b = Rational(fraction: "1/3")!
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBEqual() {
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


}
