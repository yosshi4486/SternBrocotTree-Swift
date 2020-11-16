//
//  Intermediate.swift
//  SternBroctTreeSwift
//
//  Created by seijin4486 on 2020/11/11.
//

import Foundation

/// An error that is thrown in `intermediate`.
public enum IntermediateError : LocalizedError {

    case negativeArgument(Rational, Rational)

    case leftMustBeSmallerThanRight(Rational, Rational)

    case overflow(lhs: Rational, rhs: Rational)

    public var errorDescription: String? {
        switch self {
        case .negativeArgument(_, _):
            return "arguments must be non-negative"

        case .leftMustBeSmallerThanRight(_, _):
            return "left argument must be strictly smaller than right"

        case .overflow(lhs: let lhs, rhs: let rhs):
            return "Numerator or denominator of new node exceeds Int32.max, it means overflow. lhs: \(lhs), rhs: \(rhs)"
        }
    }

}

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
/// - Parameters:
///   - left: The node positioned at left of inserting postion you expected.
///   - right: The node positioned at right of inserting postion you expected.
/// - Throws: An intermdediate error.
/// - Returns:
public func intermediate(left: Rational?, right: Rational?) throws -> Rational {

    var low = Rational.rootLow
    var high = Rational.rootHigh

    let left = left ?? low
    let right = right ?? high

    if left < low || right < low {
        throw IntermediateError.negativeArgument(left, right)
    }

    if left >= right {
        throw IntermediateError.leftMustBeSmallerThanRight(left, right)
    }

    var mediant: Rational?
    while true {
        mediant = try Rational.mediant(left: low, right: high)

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

