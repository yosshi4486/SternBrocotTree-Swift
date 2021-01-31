//
//  ReferenceRationalArithmeticTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/01.
//

import XCTest
@testable import SternBrocotTreeSwift

class NSRationalArithmeticTests: XCTestCase {

    func testCanReduce() throws {
        let rational = NSRational("3/9")
        XCTAssertTrue(rational.canReduce)
    }

    func testCannotReduce() throws {
        let rational = NSRational("3/10")
        XCTAssertFalse(rational.canReduce)
    }

    func testReduced() throws {
        let rational = NSRational("3/9")
        XCTAssertEqual(rational.reduced().description, "1/3")
    }

    func testReducedNotChanged() throws {
        let rational = NSRational("3/10")
        XCTAssertEqual(rational.reduced().description, "3/10")
    }

    func testReduce() throws {
        let rational = NSRational("3/9")
        rational.reduce()
        XCTAssertEqual(rational.description, "1/3")
    }

    func testReduceNotChanged() throws {
        let rational = NSRational("3/10")
        rational.reduce()
        XCTAssertEqual(rational.description, "3/10")
    }

    func testAdd() throws {
        let a = NSRational("1/3")
        let b = NSRational("1/3")
        let result = a.addingReportingOverflow(b).partialValue

        XCTAssertEqual(result.description, "2/3")
    }

    func testMult() throws {
        let a = NSRational("1/3")
        let b = NSRational("1/3")
        let result = a.multipliedReportingOverflow(by: b).partialValue

        XCTAssertEqual(result.description, "1/9")
    }

    func testSub() throws {
        let a = NSRational("2/3")
        let b = NSRational("1/3")
        let result = a.subtractingReportingOverflow(b).partialValue

        XCTAssertEqual(result.description, "1/3")
    }

    func testDiv() throws {
        let a = NSRational("2/3")
        let b = NSRational("1/3")
        let result = a.dividedReportingOverflow(by: b).partialValue

        XCTAssertEqual(result.description, "2/1")
    }

}
