//
//  ReferenceRationalComparisonTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/01.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBRationalComparisonTests: XCTestCase {

    func testEqual() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/3")
        XCTAssertEqual(a, b)
    }

    func testNotEqualWhenAIsLessThanB() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")
        XCTAssertNotEqual(a, b)
    }

    func testNotEqualWhenAIsGreaterThanB() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/3")
        XCTAssertNotEqual(a, b)
    }

    func testAIsLessThanB() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/3")
        XCTAssertTrue(a < b)
    }

    func testAIsLessThanBFailure() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanBFailureWhenEqual() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/4")
        XCTAssertFalse(a < b)
    }

    func testAIsLessThanEqualB() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/3")
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBWhenEqual() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/4")
        XCTAssertTrue(a <= b)
    }

    func testAIsLessThanEqualBFailure() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")
        XCTAssertFalse(a <= b)
    }

    func testAIsGreaterThanB() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")
        XCTAssertTrue(a > b)
    }

    func testAIsGreaterThanBFailure() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/3")
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanBFailureWhenEqual() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/4")
        XCTAssertFalse(a > b)
    }

    func testAIsGreaterThanEqualB() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBWhenEqual() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/4")
        XCTAssertTrue(a >= b)
    }

    func testAIsGreaterThanEqualBFailure() throws {
        let a = SBRational("1/4")
        let b = SBRational("1/3")
        XCTAssertFalse(a >= b)
    }

    func testMin() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")

        let result = min(a, b)
        XCTAssertEqual(result, b)
    }

    func testMax() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")

        let result = max(a, b)
        XCTAssertEqual(result, a)
    }

    func testHashEqual() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/3")

        XCTAssertEqual(a.hashValue, b.hashValue)
    }

    func testHashEqualWithDifferentNumbers() throws {
        let a = SBRational("1/3")
        let b = SBRational("3/9")

        XCTAssertEqual(a.hashValue, b.hashValue)
    }

    func testHashNotEqual() throws {
        let a = SBRational("1/3")
        let b = SBRational("1/4")

        XCTAssertNotEqual(a.hashValue, b.hashValue)
    }

}
