//
//  RationalArithmeticTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalArithmeticTests: XCTestCase {

    func testCanSimplify() throws {
        let rational = try Rational(fraction: "3/9")!
        XCTAssertTrue(rational.canSimplify)
    }

    func testCannotSimplify() throws {
        let rational = try Rational(fraction: "3/10")!
        XCTAssertFalse(rational.canSimplify)
    }

    func testSimplified() throws {
        let rational = try Rational(fraction: "3/9")
        XCTAssertTrue(rational!.simplifiedReportingSuccess().success)
        XCTAssertEqual(rational?.simplifiedReportingSuccess().result.description, "1/3")
    }

    func testSimplifiedNil() throws {
        let rational = try Rational(fraction: "3/10")
        XCTAssertFalse(rational!.simplifiedReportingSuccess().success)
        XCTAssertEqual(rational?.simplifiedReportingSuccess().result.description, "3/10")
    }

    func testAdd() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/3")!
        let result = try a.adding(to: b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "6/9")
    }

    func testMult() throws {
        let a = try Rational(fraction: "1/3")!
        let b = try Rational(fraction: "1/3")!
        let result = try a.multiplied(by: b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "1/9")

    }

    func testSub() throws {
        let a = try Rational(fraction: "2/3")!
        let b = try Rational(fraction: "1/3")!
        let result = try a.subtracting(b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "3/9")
    }

    func testDiv() throws {
        let a = try Rational(fraction: "2/3")!
        let b = try Rational(fraction: "1/3")!
        let result = try a.divided(by: b)

        // Why does it not reduced?
        XCTAssertEqual(result.description, "6/3")
    }


}
