//
//  InitializationError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

public enum InitializationError : LocalizedError {

    case zeroDinominator

    public var errorDescription: String? {

        switch self {
        case .zeroDinominator:
            return "Fraction cannot have zero denominator."
        }
    }
}
