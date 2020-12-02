//
//  NSRationalObjctProtocolTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/02.
//

import XCTest
@testable import SternBroctTreeSwift

class NSRationalObjctProtocolTests: XCTestCase {

    func testSuperclass() {
        let rational = NSRational(fractionWithNoError: "1/3")
        XCTAssertEqual(String(describing: rational.superclass!.self), String(describing: NSObject.self))
    }

    func testIsEqual() {
        let rationalA = NSRational(fractionWithNoError: "1/3")
        let rationalB = NSRational(fractionWithNoError: "1/3")
        XCTAssertEqual(rationalA, rationalB)
    }

    func testIsNotEqual() {
        let rationalA = NSRational(fractionWithNoError: "1/3")
        let rationalB = NSRational(fractionWithNoError: "1/2")
        XCTAssertNotEqual(rationalA, rationalB)
    }

    func testTwoRationalsHaveSameFractionReturnSameHash() {
        let rationalA = NSRational(fractionWithNoError: "1/3")
        let rationalB = NSRational(fractionWithNoError: "1/3")
        XCTAssertEqual(rationalA.hash, rationalB.hash)
    }

    func testTwoRationalsHaveDifferentFractionReturnDifferentHash() {
        let rationalA = NSRational(fractionWithNoError: "1/3")
        let rationalB = NSRational(fractionWithNoError: "1/2")
        XCTAssertNotEqual(rationalA.hash, rationalB.hash)
    }

}
