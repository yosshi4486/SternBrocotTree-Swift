//
//  RationalError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/03.
//

import Foundation

/// Error codes for rational operations.
public enum RationalError<ConcreteRational : SignedRational> : LocalizedError {

    case overflow(ConcreteRational)

    /// An overflow occured.
    case arithmeticOverflow(lhs: ConcreteRational, rhs: ConcreteRational)

    /// A fraction denominator of rational can not be zero due to mathematical rules.
    case zeroDenominator

    public var errorDescription: String? {
        switch self {

        case .overflow(let rational):
            return "An operation cause overflow \(rational)."

        case .arithmeticOverflow(let lhs, let rhs):
            return "An arithmetic operation of the lhs: \(lhs) and the rhs: \(rhs) cause overflow."
            
        case .zeroDenominator:
            return "Fraction denominator cannot be zero."
        }
    }

}

extension RationalError : Equatable { }
