//
//  ReferenceRationalToDataTransformer.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/02.
//

import UIKit

@available(iOS 12.0, *)
open class ReferenceRationalToDataTransformer : NSSecureUnarchiveFromDataTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return ReferenceRational.self
    }

    open override class var allowedTopLevelClasses: [AnyClass] {
        return [ReferenceRational.self]
    }

    public static func register() {
        let transformer = ReferenceRationalToDataTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName.referenceRationalToDataTransformer)
    }

}

extension NSValueTransformerName {

    static let referenceRationalToDataTransformer = NSValueTransformerName(rawValue: "ReferenceRationalToDataTransformer")

}
