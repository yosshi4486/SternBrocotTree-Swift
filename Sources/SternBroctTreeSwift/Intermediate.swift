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

    public var errorDescription: String? {
        switch self {
        case .negativeArgument(_, _):
            return "arguments must be non-negative"

        case .leftMustBeSmallerThanRight(_, _):
            return "left argument must be strictly smaller than right"
        }
    }

}

public func intermediate(left: Rational?, right: Rational?) throws -> Rational {

    var low = Rational.rootLow
    var high = Rational.rootHigh

    let innerLeft = left ?? low
    let innerRight = right ?? high

    if innerLeft.compare(to: low) < 0 || innerRight.compare(to: low) < 0 {
        throw IntermediateError.negativeArgument(innerLeft, innerRight)
    }

    if innerLeft.compare(to: innerRight) >= 0 {
        throw IntermediateError.leftMustBeSmallerThanRight(innerLeft, innerRight)
    }

    var mediant: Rational?
    while true {
        mediant = Rational.mediant(left: low, right: high)

        if mediant!.compare(to: innerLeft) < 1 {
            low = mediant!
        } else if mediant!.compare(to: innerRight) > -1 {
            high = mediant!
        } else {
            break
        }
    }

    return mediant!
}

