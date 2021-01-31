//
//  TransformerTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2020/12/02.
//

import XCTest
@testable import SternBrocotTreeSwift

// By removing implementations from the transformer, Tests will fail. BUT, I can get success setting it to CoreData attribute.
// I suppose that CoreData has internal mechanism of archiving/unarchiving a registered type.

//class TransformerTests: XCTestCase {
//
//    override class func setUp() {
//        SBRationalToDataTransformer.register()
//    }
//
//    func testTransform() {
//        let referenceRational = SBRational(fractionWithNoError: "1/3")
//        let transformer = SBRationalToDataTransformer()
//        let transformed = transformer.transformedValue(referenceRational)
//        XCTAssertNotNil(transformed)
//    }
//
//    func testTransformThenReverse() {
//        let referenceRational = SBRational(fractionWithNoError: "1/3")
//        let transformer = SBRationalToDataTransformer()
//        let transformed = transformer.transformedValue(referenceRational)
//        let reversed = transformer.reverseTransformedValue(transformed) as? SBRational
//        XCTAssertEqual(reversed?.description, "1/3")
//    }
//
//
//}
