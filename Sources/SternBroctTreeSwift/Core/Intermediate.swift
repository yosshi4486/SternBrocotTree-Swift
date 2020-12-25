//
//  Intermediate.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// Returns a valid new node of stern brocot tree from the given left and right nodes.
///
/// This function finds proper fruction for new node like bellow:
///
///     let initialNode = try intermediate(nil, nil)
///     // initialNode.description is 1/1
///
///     let secondNode = try intermediate(initialNode, nil)
///     // secondNode.description is 2/1
///
///     let thirdNode = try intermediate(secondNode, nil)
///     // thirdNode.description is 3/1
///
/// Give the left and right argument if possible.
///
/// - Parameters:
///   - left: The node positioned at left of inserting postion you expected.
///   - right: The node positioned at right of inserting postion you expected.
///
/// - Throws: If you see `.overflow` error, you shoud execute any normalization.
///
/// - Returns:
public func intermediate<ConcreteRational : SignedRational>(left: ConcreteRational?, right: ConcreteRational?) throws -> ConcreteRational {

    // STEP1: Validate Arguments
    
    var low = ConcreteRational.zero
    var high = ConcreteRational.infinity

    let left = left ?? low
    let right = right ?? high

    let compareResultOfLeftWithLow = left.comparedReportingOverflow(with: low)
    let compareResultOfRightWithLow = right.comparedReportingOverflow(with: low)
    guard compareResultOfLeftWithLow.partialValue != .incomparable, compareResultOfRightWithLow.partialValue != .incomparable else {
        throw RationalIntermediateError.overflow(lhs: left, rhs: right)
    }

    if (compareResultOfLeftWithLow.partialValue == .smaller) || (compareResultOfRightWithLow.partialValue == .smaller) {
        throw RationalIntermediateError.negativeArgument(lhs: left, rhs: right)
    }

    let compareResultOfLeftWithRight = left.comparedReportingOverflow(with: right)
    guard compareResultOfLeftWithRight.partialValue != .incomparable else {
        throw RationalIntermediateError.overflow(lhs: left, rhs: right)
    }

    if (compareResultOfLeftWithRight.partialValue == .bigger) || (compareResultOfLeftWithRight.partialValue == .equal) {
        throw RationalIntermediateError.leftMustBeSmallerThanRight(lhs: left, rhs: right)
    }

    // STEP2: Lightweight Computation if possible

    // If arguments are adjacent, taking mediant works perfectly.
    // It is much faster than searching sbtree.
    guard !left.isAdjacent(to: right) else {
        let result = ConcreteRational.mediantReportingOverflow(left: left, right: right)
        if !result.overflow {
            return result.partialValue
        } else {
            throw RationalIntermediateError.overflow(lhs: left, rhs: right)
        }
    }

    // STEP3: Heavyweight Computation

    // If arguments are not adjacent, search proper node which matches SB-Tree requirements.
    var mediant: ConcreteRational?
    while true {

        let result = ConcreteRational.mediantReportingOverflow(left: low, right: high)
        if !result.overflow {
            mediant = result.partialValue
        } else {
            throw RationalIntermediateError.overflow(lhs: left, rhs: right)
        }

        if mediant! <= left {
            low = mediant!
        } else if right <= mediant! {
            high = mediant!
        } else {
            break
        }
    }

    return mediant!

}

