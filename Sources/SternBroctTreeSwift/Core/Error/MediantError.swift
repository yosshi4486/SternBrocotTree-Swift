//
//  MediantError.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/01.
//

import Foundation

public enum MediantError<ConcreteRational : RationalProtocol> : LocalizedError {

    case overflow(lhs: ConcreteRational, rhs: ConcreteRational)

    public var errorDescription: String? {

        switch self {
        case .overflow(lhs: let lhs, rhs: let rhs):
            return "Overflow. lhs: \(lhs), rhs: \(rhs)"
        }
    }
}
