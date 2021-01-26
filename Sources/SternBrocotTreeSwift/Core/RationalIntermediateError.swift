//
//  IntermediateError.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/03.
//

import Foundation

/// Error codes for`intermediate`.
public enum RationalIntermediateError<ConcreteRational : Fraction> : LocalizedError {

    /// A negative value passed to an left or right.
    case negativeArgument(lhs: ConcreteRational, rhs: ConcreteRational)

    /// A bigger value than right passed to an left.
    case leftMustBeSmallerThanRight(lhs: ConcreteRational, rhs: ConcreteRational)

    /// An overflow occured in an intermediate operation.
    case overflow(lhs: ConcreteRational, rhs: ConcreteRational)

    public var errorDescription: String? {
        switch self {
        case .negativeArgument(let lhs, let rhs):
            return "Arguments(lhs: \(lhs), rhs: \(rhs) must be non-negative"

        case .leftMustBeSmallerThanRight(let lhs, let rhs):
            return "The left argument(\(lhs)) must be strictly smaller than the right(\(rhs))"
            
        case .overflow(lhs: let lhs, rhs: let rhs):
            return "A numerator or denominator of new node will exceeds Int32.max, it causes overflow. lhs: \(lhs), rhs: \(rhs)"
        }
    }

}

extension RationalIntermediateError : Equatable { }
