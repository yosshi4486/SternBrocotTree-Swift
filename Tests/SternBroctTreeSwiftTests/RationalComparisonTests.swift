//
//  try RationalComparisonTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalComparisonTests: XCTestCase {

    func testEqual() throws {
        let a = try Rational(fraction: "1/3")
        let b = try Rational(fraction: "1/3")
        XCTAssertEqual(a, b)
    }

    func testNotEqualWhenAIsLessThanB() throws {
        let a = try Rational(fraction: "1/3")
        let b = try Rational(fraction: "1/4")
        XCTAssertNotEqual(a, b)
    }

    func testNotEqualWhenAIsGreaterThanB() throws {
        let a = try Rational(fraction: "1/4")
        let b = try Rational(fraction: "1/3")
        XCTAssertNotEqual(a, b)
    }

    func testAIsLessThanB() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/3")!
        XCTAssertTrue(a < b)
    }

    func testAIsLessThanBFailure() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanBFailureWhenEqual() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanEqualB() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/3")!
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBWhenEqual() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBFailure() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertFalse(a <= b)
    }

    func testAIsGreaterThanB() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertTrue(a > b)
    }

    func testAIsGreaterThanBFailure() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/3")!
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanBFailureWhenEqual() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanEqualB() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBWhenEqual() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/4")!
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBFailure() throws {
        let a = try Rational(fraction: "1/4")!
        let b = try Rational(fraction: "1/3")!
        XCTAssertFalse(a >= b)
    }

    func testMin() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!

        let result = min(a, b)
        XCTAssertEqual(result, b)
    }

    func testMax() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!

        let result = max(a, b)
        XCTAssertEqual(result, a)
    }

    func testHashEqual() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/3")!

        XCTAssertEqual(a.hashValue, b.hashValue)
    }

    func testHashEqualWithDifferentNumbers() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "3/9")!

        XCTAssertEqual(a.hashValue, b.hashValue)
    }

    func testHashNotEqual() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/4")!

        XCTAssertNotEqual(a.hashValue, b.hashValue)
    }


}
