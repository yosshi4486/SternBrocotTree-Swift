//
//  IntermediateTimeComplexityTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2021/01/25.
//

import XCTest
@testable import SternBroctTreeSwift

class IntermediateTimeComplexityTests: XCTestCase {

    /*
     Please very a counter in the intermediate function before starting these tests.
     */

    func testTimeComplexity() throws {

        // Left: Numer: 10 ^ n(0 <= n <= 6), Denom: 1
        // Right: Number: 10 ^ n + 2 (0 <= n <= 6, avoiding adjacent), Denom: 1

        for n in 0...6 {
            let numarator: Float = pow(Float(10), Float(n))
            let denominator = 1
            let left = Rational(numerator: Int(numarator), denominator: denominator)
            let right = Rational(numerator: Int(numarator) + 2, denominator: denominator)
            let _ = try intermediate(left: left, right: right)
        }

    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
