//
//  RationalArithmeticError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

/// An arithmetic error of rational.
public enum ArithmeticError : LocalizedError {

    case outOfRange

    public var errorDescription: String? {
        switch self {
        case .outOfRange:
            return "intermediate value overflow in rational addition"
        }
    }

}
