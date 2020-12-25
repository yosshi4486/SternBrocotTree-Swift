//
//  RationalOrdering.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/16.
//

import Foundation

/// A type that a user of your application can store their user defined order as rational.
public protocol RationalUserOrderable {
    
    associatedtype ConcreteRational : Fraction

    /// The user defined order as rational.
    var rationalUserDefinedOrder: ConcreteRational { get set }

}
