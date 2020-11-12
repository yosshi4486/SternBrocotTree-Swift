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
        XCTAssertEqual(rational?.simplified()?.description, "1/3")
    }

    func testSimplifiedNil() {
        let rational = Rational(fraction: "3/10")
        XCTAssertNil(rational?.simplified())
    }

}
