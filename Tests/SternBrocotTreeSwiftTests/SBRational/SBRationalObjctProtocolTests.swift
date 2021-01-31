//
//  SBRationalObjctProtocolTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/02.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBRationalObjctProtocolTests: XCTestCase {

    func testSuperclass() {
        let rational = SBRational("1/3")
        XCTAssertEqual(String(describing: rational.superclass!.self), String(describing: NSObject.self))
    }

    func testIsEqual() {
        let rationalA = SBRational("1/3")
        let rationalB = SBRational("1/3")
        XCTAssertEqual(rationalA, rationalB)
    }

    func testIsNotEqual() {
        let rationalA = SBRational("1/3")
        let rationalB = SBRational("1/2")
        XCTAssertNotEqual(rationalA, rationalB)
    }

    func testTwoRationalsHaveSameFractionReturnSameHash() {
        let rationalA = SBRational("1/3")
        let rationalB = SBRational("1/3")
        XCTAssertEqual(rationalA.hash, rationalB.hash)
    }

    func testTwoRationalsHaveDifferentFractionReturnDifferentHash() {
        let rationalA = SBRational("1/3")
        let rationalB = SBRational("1/2")
        XCTAssertNotEqual(rationalA.hash, rationalB.hash)
    }

    func testRandom() {
        let randomRational = SBRational.random()
        XCTAssertGreaterThanOrEqual(randomRational.numerator, 0)
        XCTAssertGreaterThanOrEqual(randomRational.denominator, 1)
    }

}
