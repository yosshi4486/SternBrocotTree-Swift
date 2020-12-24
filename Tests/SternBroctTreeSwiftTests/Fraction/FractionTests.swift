//
//  FractionTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBroctTreeSwift

class FractionTests: XCTestCase {

    func testDescription() {
        let f = Fraction(numerator: 1, denominator: 10)
        XCTAssertEqual(f.description, "1/10")
    }

    func testInitFromString() {
        let f = Fraction("2/3")
        XCTAssertEqual(f.numerator, 2)
        XCTAssertEqual(f.denominator, 3)
    }

}
