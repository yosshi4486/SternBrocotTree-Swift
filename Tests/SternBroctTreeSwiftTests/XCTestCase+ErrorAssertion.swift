//
//  XCTestCase+ErrorAssertion.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/03.
//

import XCTest

// Refered swift by sundell: https://www.swiftbysundell.com/articles/testing-error-code-paths-in-swift/
extension XCTestCase {

    func XCTAssertError<T, E: Error & Equatable>(_ expression: @autoclosure () throws -> T, throws error: E, in file: StaticString = #file, line: UInt = #line) {

        var thrownError: Error?

        XCTAssertThrowsError(try expression(),
                             file: file, line: line) {
            thrownError = $0
        }

        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )

        XCTAssertEqual(
            thrownError as? E, error,
            file: file, line: line
        )
    }

}
