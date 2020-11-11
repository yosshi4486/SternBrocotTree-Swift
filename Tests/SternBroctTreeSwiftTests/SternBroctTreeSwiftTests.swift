import XCTest
@testable import SternBroctTreeSwift

final class SternBroctTreeSwiftTests: XCTestCase {

    func testMediantsOnlyLeft() throws {

        var right: Rational?

        // 1
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/1")

        // 2
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/2")

        // 3
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/3")

        // 4
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/4")

        // 5
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/5")

        // 6
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/6")

        // 7
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/7")

        // 8
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/8")

        // 9
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/9")

        // 10
        right = try intermediate(left: nil, right: right)
        XCTAssertEqual(right?.description, "1/10")
    }

    func testFibonacciPath() throws {
        
        var left: Rational?
        var right: Rational?

        // 1
        right = try intermediate(left: left, right: right)
        XCTAssertEqual(right?.description, "1/1")

        // 2
        left = try intermediate(left: left, right: right)
        XCTAssertEqual(left?.description, "1/2")

        // 3
        right = try intermediate(left: left, right: right)
        XCTAssertEqual(right?.description, "2/3")

        // 4
        left = try intermediate(left: left, right: right)
        XCTAssertEqual(left?.description, "3/5")

        // 5
        right = try intermediate(left: left, right: right)
        XCTAssertEqual(right?.description, "5/8")

        // 6
        left = try intermediate(left: left, right: right)
        XCTAssertEqual(left?.description, "8/13")

        // 7
        right = try intermediate(left: left, right: right)
        XCTAssertEqual(right?.description, "13/21")

        // 8
        left = try intermediate(left: left, right: right)
        XCTAssertEqual(left?.description, "21/34")

        // 9
        right = try intermediate(left: left, right: right)
        XCTAssertEqual(right?.description, "34/55")

        // 10
        left = try intermediate(left: left, right: right)
        XCTAssertEqual(left?.description, "55/89")

    }

    static var allTests = [
        ("testMediantsOnlyLeft", testMediantsOnlyLeft),
    ]
}
