//
//  OrderProviderTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/17.
//

import XCTest
@testable import SternBroctTreeSwift

class ArrayPlusRationalExtensionTests: XCTestCase {

    struct StubRationalOrderable : RationalUserOrderable {
        var rationalUserDefinedOrder: Rational
    }

    func testMakeFibonacciPathArray() {

        // Preparation
        let array: Array<StubRationalOrderable>

        // Execution
        array = makeFibonacciPathArray()

        //Assertion
        XCTAssertEqual(array[0].rationalUserDefinedOrder.description, "1/2")
        XCTAssertEqual(array[1].rationalUserDefinedOrder.description, "3/5")
        XCTAssertEqual(array[2].rationalUserDefinedOrder.description, "8/13")
        XCTAssertEqual(array[3].rationalUserDefinedOrder.description, "5/8")
        XCTAssertEqual(array[4].rationalUserDefinedOrder.description, "2/3")
        XCTAssertEqual(array[5].rationalUserDefinedOrder.description, "1/1")

        // Visualize
        for element in array {
            print("fraction: \(element.rationalUserDefinedOrder), float: \(element.rationalUserDefinedOrder.float64Value)")
        }
    }

    func testNormalize() throws {

        // Preparation
        var array = makeFibonacciPathArray()

        // Execution
        array.normalize()

        // Assertion
        XCTAssertEqual(array[0].rationalUserDefinedOrder.description, "1/1")
        XCTAssertEqual(array[1].rationalUserDefinedOrder.description, "2/1")
        XCTAssertEqual(array[2].rationalUserDefinedOrder.description, "3/1")
        XCTAssertEqual(array[3].rationalUserDefinedOrder.description, "4/1")
        XCTAssertEqual(array[4].rationalUserDefinedOrder.description, "5/1")
        XCTAssertEqual(array[5].rationalUserDefinedOrder.description, "6/1")
    }

    // Average 0.008
    func testNormalizePerformance() throws {
        
        // Preparation
        var array = (1..<100000).compactMap({ try? Rational(numerator: 1, denominator: $0)} ).map({ StubRationalOrderable(rationalUserDefinedOrder: $0) })
        
        let comparator = try Rational(fraction: "1/1")!
        XCTAssertTrue(array.allSatisfy({ $0.rationalUserDefinedOrder <= comparator }))
        
        // Execution and Measurement
        measure {
            array.normalize()
        }
        
        XCTAssertTrue(array.allSatisfy({ $0.rationalUserDefinedOrder >= comparator }))
    }

    func makeFibonacciPathArray() -> Array<StubRationalOrderable> {
        return (0...5)
            .compactMap({ try? Rational(numerator: fib(n: $0), denominator: fib(n: $0 + 1)) })
            .sorted()
            .map({ StubRationalOrderable(rationalUserDefinedOrder: $0) })
    }

    func fib(n: Int32) -> Int32 {
        var a: Int32 = 1
        var b: Int32 = 1
        guard n > 1 else { return a }

        (2...n).forEach { _ in
            (a, b) = (a + b, a)
        }
        return a
    }
}
