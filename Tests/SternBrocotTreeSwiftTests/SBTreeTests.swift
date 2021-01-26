//
//  SBTreeTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2021/01/26.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBTreeTests: XCTestCase {

    func testInitFromSpecifiedHeight1() {
        let tree = SBTree<Rational>(height: 1)
        XCTAssertEqual(tree.nodes.map(\.description), ["1/1"])
    }

    func testInitFromSpecifiedHeight2() {
        let tree = SBTree<Rational>(height: 2)
        XCTAssertEqual(tree.nodes.map(\.description), ["1/2", "1/1", "2/1"])
    }

    func testInitFromSpecifiedHeight3() {
        let tree = SBTree<Rational>(height: 3)
        XCTAssertEqual(tree.nodes.map(\.description), ["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"])
    }

    func testInitFromSpecifiedHeight4() {
        let tree = SBTree<Rational>(height: 4)
        XCTAssertEqual(tree.nodes.map(\.description), ["1/4" ,"1/3", "2/5", "1/2", "3/5", "2/3", "3/4", "1/1", "4/3", "3/2", "5/3", "2/1", "5/2", "3/1", "4/1"])
    }

}
