//
//  Matrix2x2Tests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/24.
//

import XCTest
@testable import SternBroctTreeSwift

class Matrix2x2Tests: XCTestCase {

    func testAddingXY() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result = matrixX + matrixY

        XCTAssertEqual(result.a, 5)
        XCTAssertEqual(result.b, 4)
        XCTAssertEqual(result.c, 13)
        XCTAssertEqual(result.d, 12)
    }

    func testAddingYX() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result =  matrixY + matrixX

        XCTAssertEqual(result.a, 5)
        XCTAssertEqual(result.b, 4)
        XCTAssertEqual(result.c, 13)
        XCTAssertEqual(result.d, 12)
    }

    func testSubtractingXY() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result = matrixX - matrixY

        XCTAssertEqual(result.a, -1)
        XCTAssertEqual(result.b, 2)
        XCTAssertEqual(result.c, 9)
        XCTAssertEqual(result.d, 4)
    }

    func testSubtractingYX() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result =  matrixY - matrixX

        XCTAssertEqual(result.a, 1)
        XCTAssertEqual(result.b, -2)
        XCTAssertEqual(result.c, -9)
        XCTAssertEqual(result.d, -4)
    }

    func testMultiplyXY() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result = matrixX * matrixY

        XCTAssertEqual(result.a, 12)
        XCTAssertEqual(result.b, 14)
        XCTAssertEqual(result.c, 49)
        XCTAssertEqual(result.d, 43)
    }

    func testMultiplyYX() {
        let matrixX = Matrix2x2(a: 2, b: 3, c: 11, d: 8)
        let matrixY = Matrix2x2(a: 3, b: 1, c: 2, d: 4)
        let result =  matrixY * matrixX

        XCTAssertEqual(result.a, 17)
        XCTAssertEqual(result.b, 17)
        XCTAssertEqual(result.c, 48)
        XCTAssertEqual(result.d, 38)
    }

}
