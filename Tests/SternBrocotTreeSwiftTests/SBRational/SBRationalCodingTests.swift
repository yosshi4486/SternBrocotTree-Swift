//
//  SBRationalCodingTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2021/04/26.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBRationalCodingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncodeAndDecode() throws {
        let sourceRational = SBRational(numerator: 234, denominator: 567)
        let encoded = try JSONEncoder().encode(sourceRational)
        let decoded = try JSONDecoder().decode(SBRational.self, from: encoded)
        XCTAssertEqual(decoded.numerator, 234)
        XCTAssertEqual(decoded.denominator, 567)
    }

}
