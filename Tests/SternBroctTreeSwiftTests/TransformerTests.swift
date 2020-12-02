//
//  TransformerTests.swift
//  SternBroctTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/02.
//

import XCTest
@testable import SternBroctTreeSwift

class TransformerTests: XCTestCase {

    override class func setUp() {
        NSRationalToDataTransformer.register()
    }
    
    func testTransform() {
        let referenceRational = NSRational(fractionWithNoError: "1/3")
        let transformer = NSRationalToDataTransformer()
        let transformed = transformer.transformedValue(referenceRational)
        XCTAssertNotNil(transformed)
    }

    func testTransformThenReverse() {
        let referenceRational = NSRational(fractionWithNoError: "1/3")
        let transformer = NSRationalToDataTransformer()
        let transformed = transformer.transformedValue(referenceRational)
        let reversed = transformer.reverseTransformedValue(transformed)
        XCTAssertNotNil(reversed)
    }

    
}
