//
//  SBTreeTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2021/01/26.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBTreeTests: XCTestCase {

    func testInitFromSpecifiedHeight() {
        let tree = SBTree<Rational>(height: 1)
        XCTAssertEqual(tree.nodes.map(\.description), ["1/1"])
    }

}
