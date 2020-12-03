//
//  InitializationError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// Error codes for rational's initialization.
public enum RationalInitializationError : LocalizedError {

    /// A fraction denominator of rational can not be zero due to mathematical rules.
    case zeroDenominator

    public var errorDescription: String? {
        switch self {
        case .zeroDenominator:
            return "Fraction denominator cannot be zero."
        }
    }

}
