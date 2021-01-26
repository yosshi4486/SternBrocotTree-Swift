import XCTest
@testable import SternBrocotTreeSwift

final class IntermediateTests: XCTestCase {

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

    // In SBTree, go down LRLRLR... makes fibonacci sequence.
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

    func testIntermediatePassingFarValues() throws {
        let left = Rational("1/1")
        let right = Rational("5/2")
        let result = try intermediate(left: left, right: right)

        XCTAssertEqual(result.description, "2/1")
    }

    func testErrorNegativeArguments() {
        let left = Rational("-1/1")
        let right = Rational("1/0")
        XCTAssertError(try intermediate(left: left, right: nil),
                       throws: RationalIntermediateError<Rational>.negativeArgument(lhs: left, rhs: right))
    }

    func testErrorLeftArgIsSmallerThanRight() {
        let left = Rational("2/3")
        let right = Rational("1/3")
        XCTAssertError(try intermediate(left: left, right: right),
                       throws: RationalIntermediateError<Rational>.leftMustBeSmallerThanRight(lhs: left, rhs: right))
    }

    func testErrorLeftArgIsSmallerThanRightWhenEqual() {
        let left = Rational("2/3")
        let right = Rational("2/3")
        XCTAssertError(try intermediate(left: left, right: right),
                       throws: RationalIntermediateError<Rational>.leftMustBeSmallerThanRight(lhs: left, rhs: right))
    }

    func testMediantErrorOverflowDenominator() {
        let left = Rational32("1/2147483647")
        let right = Rational32("1/1")
        let result = Rational32.mediantReportingOverflow(left: left, right: right)
        XCTAssertTrue(result.overflow)
    }

    func testMediantErrorOverflowNumerator() {
        let left = Rational32("1/1")
        let right = Rational32("2147483647/1")
        let result = Rational32.mediantReportingOverflow(left: left, right: right)
        XCTAssertTrue(result.overflow)
    }

    static var allTests = [
        ("testMediantsOnlyLeft", testMediantsOnlyLeft),
    ]
}
