//
//  OrderProviderTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/17.
//

import XCTest
@testable import SternBroctTreeSwift

class ArrayPlusRationalExtensionTests: XCTestCase {

    struct StubRationalOrderable : RationalOrderable {
        var rational: Rational
    }

    func testAppendingNil() throws {

        // Preparation
        let array = Array<StubRationalOrderable>()

        // Execution
        let result = try array.rationalForAppending()

        // Assertion
        XCTAssertNil(result)
    }

    func testAppending() throws {

        // Preparation
        var array = Array<StubRationalOrderable>()
        array.append(.init(rational: try Rational(fraction: "1/1")!))

        // Execution
        let result = try array.rationalForAppending()

        // Assertion
        XCTAssertEqual(result?.description, "2/1")
    }

    func testInsertingSingle() throws {

        // Preparation
        let array = Array<StubRationalOrderable>()

        // Execution
        let result = try array.rationalForInserting(between: .init(rational: try Rational(fraction: "3/2")!),
                                                    and: .init(rational: try Rational(fraction: "2/1")!))

        // Assertion
        XCTAssertEqual(result.first?.description, "5/3")
    }

    func testInsertingCollection() throws {

        // Preparation
        let array = Array<StubRationalOrderable>()

        // Execution
        let result = try array.rationalForInserting(between: .init(rational: try Rational(fraction: "3/2")!),
                                                    and: .init(rational: try Rational(fraction: "2/1")!),
                                                    numberOfItems: 3)

        // Assertion
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].description, "5/3")
        XCTAssertEqual(result[1].description, "7/4")
        XCTAssertEqual(result[2].description, "9/5")
    }

    func testMakeFibonacciPathArray() {

        // Preparation
        let array: Array<StubRationalOrderable>

        // Execution
        array = makeFibonacciPathArray()

        //Assertion
        XCTAssertEqual(array[0].rational.description, "1/2")
        XCTAssertEqual(array[1].rational.description, "3/5")
        XCTAssertEqual(array[2].rational.description, "8/13")
        XCTAssertEqual(array[3].rational.description, "5/8")
        XCTAssertEqual(array[4].rational.description, "2/3")
        XCTAssertEqual(array[5].rational.description, "1/1")

        // Visualize
        for element in array {
            print("fraction: \(element.rational), float: \(element.rational.float64Value)")
        }
    }

    func testNormalize() throws {

        // Preparation
        var array = makeFibonacciPathArray()

        // Execution
        try array.normalize()

        // Assertion
        XCTAssertEqual(array[0].rational.description, "1/1")
        XCTAssertEqual(array[1].rational.description, "2/1")
        XCTAssertEqual(array[2].rational.description, "3/1")
        XCTAssertEqual(array[3].rational.description, "4/1")
        XCTAssertEqual(array[4].rational.description, "5/1")
        XCTAssertEqual(array[5].rational.description, "6/1")
    }

    // Average 0.008
    func testNormalizePerformance() throws {
        
        // Preparation
        var array = (1..<100000).compactMap({ try? Rational(numerator: 1, denominator: $0)} ).map({ StubRationalOrderable(rational: $0) })
        
        let comparator = try Rational(fraction: "1/1")!
        XCTAssertTrue(array.allSatisfy({ $0.rational <= comparator }))
        
        // Execution and Measurement
        measure {
            try? array.normalize()
        }
        
        XCTAssertTrue(array.allSatisfy({ $0.rational >= comparator }))
    }

    func makeFibonacciPathArray() -> Array<StubRationalOrderable> {
        return (0...5)
            .compactMap({ try? Rational(numerator: fib(n: $0), denominator: fib(n: $0 + 1)) })
            .sorted()
            .map({ StubRationalOrderable(rational: $0) })
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
