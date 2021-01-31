//
//  SBTreeTests.swift
//  SternBrocotTreeSwiftTests
//
//  Created by yosshi4486 on 2021/01/26.
//

import XCTest
@testable import SternBrocotTreeSwift

class SBTreeTests: XCTestCase {

    // MARK: - Programmer Tests

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

    func testInitEnoughRoomCase() {

        // Around 2 ^ 3
        XCTContext.runActivity(named: "Before Boundary Value 2 ^ 3") { (_) in
            let tree = SBTree<Rational>(numberOfNodes: 7)
            XCTAssertEqual(tree.nodes.count, 7)
        }

        XCTContext.runActivity(named: "Next Boundary Value 2 ^ 3") { (_) in
            let tree = SBTree<Rational>(numberOfNodes: 8)
            XCTAssertEqual(tree.nodes.count, 15)
        }

        // Around 2 ^ 4
        XCTContext.runActivity(named: "Before Boundary Value 2 ^ 4") { (_) in
            let tree = SBTree<Rational>(numberOfNodes: 15)
            XCTAssertEqual(tree.nodes.count, 15)
        }

        XCTContext.runActivity(named: "Next Boundary Value 2 ^ 4") { (_) in
            let tree = SBTree<Rational>(numberOfNodes: 16)
            XCTAssertEqual(tree.nodes.count, 31)
        }

    }

    func testNodesInDepth1() {
        let nodes = SBTree<Rational>.nodesInDepth(1)
        XCTAssertEqual(nodes.map(\.description), ["1/1"])
    }

    func testNodesInDepth2() {
        let nodes = SBTree<Rational>.nodesInDepth(2)
        XCTAssertEqual(nodes.map(\.description), ["1/2", "2/1"])
    }

    func testNodesInDepth3() {
        let nodes = SBTree<Rational>.nodesInDepth(3)
        XCTAssertEqual(nodes.map(\.description), ["1/3", "2/3", "3/2", "3/1"])
    }

    func testNodesInDepth4() {
        let nodes = SBTree<Rational>.nodesInDepth(4)
        XCTAssertEqual(nodes.map(\.description),  ["1/4", "2/5", "3/5", "3/4", "4/3", "5/3", "5/2", "4/1"])
    }

    // MARK: - Mathematical Property Tests

    /// The sum of the simplicities along any row of the Stern-Brocot tree is 1.
    ///
    /// https://youtu.be/CiO8iAYC6xI?t=1513
    func testSimplicity() {
        for i in 1...5 {
            let nodes = SBTree<Rational>.nodesInDepth(i)
            let simplicities = nodes.map({ $0.simplicity() })
            let sum = simplicities.reduce(into: Rational(numerator: 0, denominator: 0)) { (result, value) in
                result += value.partialValue
            }

            XCTAssertEqual(sum.numerator, sum.denominator)
        }
    }

    /// The sum of the totals along any row is twice a power of 3. The sum for the n ^ th row (beginning 1/n) is 2 * 3 ^ (n-1)
    ///
    /// https://youtu.be/CiO8iAYC6xI?t=1628
    func testTotal() {
        for i in 1...5 {
            let nodes = SBTree<Rational>.nodesInDepth(i)
            let simplicities = nodes.map({ $0.total })
            let sum = simplicities.reduce(into: 0) { (result, value) in
                result += value
            }

            XCTAssertEqual(Double(sum), Double(2) * pow(Double(3), Double(i-1)))
        }
    }

}

