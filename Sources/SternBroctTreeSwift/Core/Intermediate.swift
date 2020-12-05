//
//  Intermediate.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

import Foundation

/// Returns a new node from the given left and right nodes.
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
/// - Throws: If you see `.overflow` error, user may walk fibonacci path 47 times. In that situation, re-normalization should be executed.
///
/// - Returns:
public func intermediate<ConcreteRational : RationalProtocol>(left: ConcreteRational?, right: ConcreteRational?) throws -> ConcreteRational {

    let low = ConcreteRational.zero
    let high = ConcreteRational.infinity

    let left = left ?? low
    let right = right ?? high

    if left < low || right < low {
        throw RationalIntermediateError.negativeArgument(lhs: left, rhs: right)
    }

    if left >= right {
        throw RationalIntermediateError.leftMustBeSmallerThanRight(lhs: left, rhs: right)
    }

    /*
     Old implemetation using while loop took too long time to approximate a fruction has large numer or denom,
     so I've changed it to new, but it may have some mathematical problems what I don't understand.

     var mediant: ConcreteRational?
     while true {

         do {
             mediant = try ConcreteRational.mediant(left: low, right: high)
         } catch {
             throw RationalIntermediateError.overflow(lhs: low, rhs: high)
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
     */

    do {
        return try ConcreteRational.mediant(left: left, right: right)
    } catch {
        throw RationalIntermediateError.overflow(lhs: left, rhs: right)
    }

}

