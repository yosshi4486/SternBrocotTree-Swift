//
//  RationalArithmeticTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

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
        let result = try a.adding(to: b)

        XCTAssertEqual(result.description, "2/3")
    }

    func testMult() throws {
        let a = Rational("1/3")
        let b = Rational("1/3")
        let result = try a.multiplied(by: b)

        XCTAssertEqual(result.description, "1/9")
    }

    func testSub() throws {
        let a = Rational("2/3")
        let b = Rational("1/3")
        let result = try a.subtracting(b)

        XCTAssertEqual(result.description, "1/3")
    }

    func testDiv() throws {
        let a = Rational("2/3")
        let b = Rational("1/3")
        let result = try a.divided(by: b)

        XCTAssertEqual(result.description, "2/1")
    }


}
