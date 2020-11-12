//
//  RationalArithmeticTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalArithmeticTests: XCTestCase {

    func testSimplified() {
        let rational = Rational(fraction: "3/9")
        XCTAssertTrue(rational!.simplifiedReportingSuccess().success)
        XCTAssertEqual(rational?.simplifiedReportingSuccess().result.description, "1/3")
    }

    func testSimplifiedNil() {
        let rational = Rational(fraction: "3/10")
        XCTAssertFalse(rational!.simplifiedReportingSuccess().success)
        XCTAssertEqual(rational?.simplifiedReportingSuccess().result.description, "3/10")
    }

    func testAdd() throws {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/3")!
        let result = try a.adding(to: b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "6/9")
    }

    func testMult() throws {
        let a = Rational(fraction: "1/3")!
        let b = Rational(fraction: "1/3")!
        let result = try a.multiplied(to: b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "1/9")

    }

    func testSub() throws {
        let a = Rational(fraction: "2/3")!
        let b = Rational(fraction: "1/3")!
        let result = try a.subtracting(b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "3/9")
    }

}
