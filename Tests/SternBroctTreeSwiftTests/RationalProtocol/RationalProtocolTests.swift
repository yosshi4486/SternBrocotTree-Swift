//
//  RationalProtocolTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalProtocolTests: XCTestCase {

    func testAdjacent() {
        let left = Rational(fractionWithNoError: "2/3")
        let right = Rational(fractionWithNoError: "3/4")

        XCTAssertTrue(left.isAdjacent(to: right))
        XCTAssertTrue(right.isAdjacent(to: left))
    }

    func testNotAdjacent() {
        let left = Rational(fractionWithNoError: "2/1")
        let right = Rational(fractionWithNoError: "3/4")

        XCTAssertFalse(left.isAdjacent(to: right))
        XCTAssertFalse(right.isAdjacent(to: left))
    }

}
