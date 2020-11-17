//
//  OrderProviderTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by seijin4486 on 2020/11/17.
//

import XCTest
@testable import SternBroctTreeSwift

class OrderProviderTests: XCTestCase {

    struct StubProvider : OrderProvider {

        struct Item : RationalOrderable {
            var rational: Rational
        }

        var items: [Item] = []
    }

    func testAppendingNil() throws {

        // Preparation
        let provider = StubProvider()

        // Execution
        let result = try provider.provideRationalForAppending()

        // Assertion
        XCTAssertNil(result)
    }

    func testAppending() throws {

        // Preparation
        var provider = StubProvider()
        provider.items.append(.init(rational: try Rational(fraction: "1/1")!))

        // Execution
        let result = try provider.provideRationalForAppending()

        // Assertion
        XCTAssertEqual(result?.description, "2/1")
    }

    func testInsertingSingle() throws {

        // Preparation
        let provider = StubProvider()

        // Execution
        let result = try provider.provideRationalForInserting(between: .init(rational: Rational(fraction: "3/2")!),
                                                              and: .init(rational: Rational(fraction: "2/1")!))

        // Assertion
        XCTAssertEqual(result.first?.description, "5/3")
    }

    func testInsertingCollection() throws {

        // Preparation
        let provider = StubProvider()

        // Execution
        let result = try provider.provideRationalForInserting(between: .init(rational: Rational(fraction: "3/2")!),
                                                              and: .init(rational: Rational(fraction: "2/1")!),
                                                              numberOfItems: 3)

        // Assertion
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].description, "5/3")
        XCTAssertEqual(result[1].description, "7/4")
        XCTAssertEqual(result[2].description, "9/5")
    }


}
