//
//  RationalError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/03.
//

import Foundation

/// Error codes for rational operations.
public enum RationalError<ConcreteRational : RationalProtocol> : LocalizedError {

    /// An overflow occured.
    case overflow(lhs: ConcreteRational, rhs: ConcreteRational, operation: String)

    /// A fraction denominator of rational can not be zero due to mathematical rules.
    case zeroDenominator

    public var errorDescription: String? {
        switch self {
        case .overflow(let lhs, let rhs, let operation):
            return "The rational operation: \(operation) of the lhs: \(lhs) and the rhs: \(rhs) cause overflow."
            
        case .zeroDenominator:
            return "Fraction denominator cannot be zero."
        }
    }

}
