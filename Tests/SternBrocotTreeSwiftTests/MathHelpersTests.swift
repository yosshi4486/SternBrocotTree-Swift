//
//  MathHelpersTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/12.
//

import XCTest
@testable import SternBrocotTreeSwift

class MathHelpersTests: XCTestCase {

    func testGCD() {
        XCTAssertEqual(gcd(3, 7), 1) // prime number
        XCTAssertEqual(gcd(24, 8), 8)
        XCTAssertEqual(gcd(1071, 1029), 21)
    }


}
