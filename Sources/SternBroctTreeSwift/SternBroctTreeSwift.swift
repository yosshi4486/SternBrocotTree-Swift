//
//  SternBrocotTreeSwift.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/11/11.
//

extension Bool {

    var intValue: Int32 {
        return self == true ? 1 : 0
    }

}


func cmp(lhs: Rational, rhs: Rational) -> Int32 {

    let cross1: Int64 = Int64(lhs.numerator * rhs.denominator)
    let cross2: Int64 = Int64(lhs.denominator * rhs.numerator)

    return (cross1 > cross2).intValue - (cross1 < cross2).intValue
}

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

    if cmp(lhs: innerLeft, rhs: low) < 0 || cmp(lhs: innerRight, rhs: low) < 0 {
        throw IntermediateError.negativeArgument(innerLeft, innerRight)
    }

    if cmp(lhs: innerLeft, rhs: innerRight) >= 0 {
        throw IntermediateError.leftMustBeSmallerThanRight(innerLeft, innerRight)
    }

    var mediant: Rational?
    while true {
        mediant = getMediant(left: low, right: high)
        if cmp(lhs: mediant!, rhs: innerLeft) < 1 {
            low = mediant!
        } else if cmp(lhs: mediant!, rhs: innerRight) > -1 {
            high = mediant!
        } else {
            break
        }
    }

    return mediant!
}

