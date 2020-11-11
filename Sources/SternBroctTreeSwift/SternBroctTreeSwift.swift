//
//  SternBrocotTreeSwift.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

/// An error that is thrown in `intermediate`.
enum IntermediateError : Error {

    case negativeArgument(Rational, Rational)

    case leftMustBeSmallerThanRight(Rational, Rational)
}

extension IntermediateError {

    var errorDescription: String {
        switch self {
        case .negativeArgument(_, _):
            return "arguments must be non-negative"

        case .leftMustBeSmallerThanRight(_, _):
            return "left argument must be strictly smaller than right"
        }
    }

}

func getMediant(left: Rational, right: Rational) -> Rational {
    return .init(numerator: left.numerator + right.numerator,
                 denominator: left.denominator + right.denominator)
}

func intermediate(left: Rational?, right: Rational?) throws -> Rational {

    var low = Rational(numerator: 0, denominator: 1)
    var high = Rational(numerator: 1, denominator: 0)

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
        mediant = getMediant(left: low, right: high)
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

