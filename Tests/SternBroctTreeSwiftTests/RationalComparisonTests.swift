//
//  RationalComparisonTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBroctTreeSwift

class RationalComparisonTests: XCTestCase {

    func testEqual() {
        let a = Rational(fraction: "1/3")
        let b = Rational(fraction: "1/3")
        XCTAssertEqual(a, b)
    }

    func testNotEqual() {
        let a = Rational(fraction: "1/3")
        let b = Rational(fraction: "1/4")
        XCTAssertNotEqual(a, b)
    }

}
