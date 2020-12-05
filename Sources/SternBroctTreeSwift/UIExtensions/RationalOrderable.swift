//
//  RationalOrdering.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/11/16.
//

import Foundation

public protocol RationalOrderable {
    
    associatedtype ConcreteRational : RationalProtocol

    var rational: ConcreteRational { get set }

}
