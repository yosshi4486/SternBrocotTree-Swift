//
//  Matrix2x2Tests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBMatrix2x2Tests: XCTestCase {
    var matrixX: SBMatrix2x2!
    var matrixY: SBMatrix2x2!

    override func setUpWithError() throws {
        matrixX = SBMatrix2x2(a: 2, b: 3, c: 11, d: 8)
        matrixY = SBMatrix2x2(a: 3, b: 1, c: 2, d: 4)
    }

    override func tearDownWithError() throws {
        matrixX = nil
        matrixY = nil
    }

    func testAddingXY() {
        let result = matrixX + matrixY

        XCTAssertEqual(result.a, 5)
        XCTAssertEqual(result.b, 4)
        XCTAssertEqual(result.c, 13)
        XCTAssertEqual(result.d, 12)
    }

    func testAddingYX() {
        let result =  matrixY + matrixX

        XCTAssertEqual(result.a, 5)
        XCTAssertEqual(result.b, 4)
        XCTAssertEqual(result.c, 13)
        XCTAssertEqual(result.d, 12)
    }

    func testSubtractingXY() {
        let result = matrixX - matrixY

        XCTAssertEqual(result.a, -1)
        XCTAssertEqual(result.b, 2)
        XCTAssertEqual(result.c, 9)
        XCTAssertEqual(result.d, 4)
    }

    func testSubtractingYX() {
        let result =  matrixY - matrixX

        XCTAssertEqual(result.a, 1)
        XCTAssertEqual(result.b, -2)
        XCTAssertEqual(result.c, -9)
        XCTAssertEqual(result.d, -4)
    }

    func testMultiplyXY() {
        let result = matrixX * matrixY

        XCTAssertEqual(result.a, 12)
        XCTAssertEqual(result.b, 14)
        XCTAssertEqual(result.c, 49)
        XCTAssertEqual(result.d, 43)
    }

    func testMultiplyYX() {
        let result =  matrixY * matrixX

        XCTAssertEqual(result.a, 17)
        XCTAssertEqual(result.b, 17)
        XCTAssertEqual(result.c, 48)
        XCTAssertEqual(result.d, 38)
    }

    func testMultiplyAssignXY() {
        matrixX *= matrixY

        XCTAssertEqual(matrixX.a, 12)
        XCTAssertEqual(matrixX.b, 14)
        XCTAssertEqual(matrixX.c, 49)
        XCTAssertEqual(matrixX.d, 43)
    }

    func testMultiplyAssignYX() {
        matrixY *= matrixX

        XCTAssertEqual(matrixY.a, 17)
        XCTAssertEqual(matrixY.b, 17)
        XCTAssertEqual(matrixY.c, 48)
        XCTAssertEqual(matrixY.d, 38)
    }

    func testRecoveredRational() throws {
        let rational: Rational = matrixX.rationalRepresentation
        XCTAssertEqual(rational.description, "5/19")
    }

    func testMoveLeft() {
        var initial = SBMatrix2x2.identity
        initial.moveLeft()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 0, c: 1, d: 1))

        initial.moveLeft()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 0, c: 2, d: 1))

        initial.moveLeft()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 0, c: 3, d: 1))

        initial.moveLeft()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 0, c: 4, d: 1))
    }

    func testMoveRight() {
        var initial = SBMatrix2x2.identity
        initial.moveRight()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 1, c: 0, d: 1))

        initial.moveRight()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 2, c: 0, d: 1))

        initial.moveRight()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 3, c: 0, d: 1))

        initial.moveRight()
        XCTAssertEqual(initial, SBMatrix2x2(a: 1, b: 4, c: 0, d: 1))
    }

    func testMakeLeft() {
        let initial = SBMatrix2x2(a: 3, b: 1, c: 2, d: 1)
        XCTAssertEqual(initial.makeLeft(), SBMatrix2x2(a: 4, b: 1, c: 3, d: 1))
    }

    func testMakeRight() {
        let initial = SBMatrix2x2(a: 3, b: 1, c: 2, d: 1)
        XCTAssertEqual(initial.makeRight(), SBMatrix2x2(a: 3, b: 4, c: 2, d: 3))
    }

    /// Determinants shoud be 1, so random tests are always success if the implementations is good.
    func testDeterminants() {
        for _ in 0..<100 {
            var node = SBMatrix2x2.identity

            // If the loop bellow is over 30, you may step fibonacci path and fails this test, so I choose 20.
            (0..<Int.random(in: 0..<20)).forEach({ _ in
                let isR = Bool.random()
                if isR {
                    node.moveRight()
                } else {
                    node.moveLeft()
                }
            })
            XCTAssertEqual(node.determinants, 1)
        }
    }

}
