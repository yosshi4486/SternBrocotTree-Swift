//
//  RationalArithmeticError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// Error codes for rational's arthmetic operations.
public enum RationalArithmeticError<ConcreteRational : RationalProtocol> : LocalizedError {

    /// An overflow occured.
    case overflow(self: ConcreteRational, other: ConcreteRational)

    public var errorDescription: String? {
        switch self {
        case .overflow(let `self`, let other):
            return "A rational operation of self: \(`self`) and other: \(other) cause overflow."
        }
    }

}
