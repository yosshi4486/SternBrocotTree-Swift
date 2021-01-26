//
//  ReferenceRationalToDataTransformer.swift
//  SternBrocotTreeSwift
//
//  Created by yosshi4486 on 2020/12/02.
//

import Foundation

@available(iOS 12.0, macOS 10.14, *)
@objc(NSRationalToDataTransformer)
open class NSRationalToDataTransformer : NSSecureUnarchiveFromDataTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSRational.self
    }

    // CoreData seems to visit this computed property to determine whether a registered type can archive/unarchive or not.
    // Refered [Here’s what is happening]: https://www.kairadiagne.com/2020/01/13/nssecurecoding-and-transformable-properties-in-core-data.html
    open override class var allowedTopLevelClasses: [AnyClass] {
        return [NSRational.self]
    }

    public static func register() {
        let transformer = NSRationalToDataTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName.NSRationalToDataTransformer)
    }

}

extension NSValueTransformerName {

    public static let NSRationalToDataTransformer = NSValueTransformerName(rawValue: "NSRationalToDataTransformer")

}
