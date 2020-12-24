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

    func testAdjacentLeftNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational(fractionWithNoError: "1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "1/2")))
        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "2/3")))
        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "3/4")))
    }

    func testAdjacentRightNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational(fractionWithNoError: "1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "2/1")))
        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "3/2")))
        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "4/3")))
    }

    func testNotAdjacentLeftNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational(fractionWithNoError: "1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "1/2")))
        XCTAssertFalse(s.isAdjacent(to: Rational(fractionWithNoError: "1/3")))
        XCTAssertFalse(s.isAdjacent(to: Rational(fractionWithNoError: "1/4")))
    }

    func testNotAdjacentRightNodesOnRegionBoundary() {
        // Test Rs where s is 1/1.
        let s = Rational(fractionWithNoError: "1/1")

        XCTAssertTrue(s.isAdjacent(to: Rational(fractionWithNoError: "2/1")))
        XCTAssertFalse(s.isAdjacent(to: Rational(fractionWithNoError: "3/1")))
        XCTAssertFalse(s.isAdjacent(to: Rational(fractionWithNoError: "4/1")))
    }

    func testSimplicity() {
        let r = Rational(fractionWithNoError: "2/3")
        XCTAssertEqual(r.simplicity, Rational(fractionWithNoError: "1/6"))
    }

    func testSumOfSimplicitiesForRow() throws {
        let rows: [Rational] = [
            Rational(fractionWithNoError: "1/3"),
            Rational(fractionWithNoError: "2/3"),
            Rational(fractionWithNoError: "3/2"),
            Rational(fractionWithNoError: "3/1")
        ]
        let simplicities = rows.map({ $0.simplicity })
        let sum = try simplicities[0]
            .adding(to: simplicities[1])
            .adding(to: simplicities[2])
            .adding(to: simplicities[3])

        XCTAssertEqual(sum.description, "1/1")
    }

}
