//
//  ReferenceRationalToDataTransformer.swift
//  SternBroctTreeSwift
//
//  Created by yosshi4486 on 2020/12/02.
//

import Foundation

// FIXME: 
// Setting NSRationalToDataTransformer to .xcdatamodeld property attribute, CoreData doesn't call transformedValue(:).
// Implementation of this class may have some problems what I don't understand.
//
// For workaround, settting empty to it, then, setting 'NSRational' to 'Custom Class' attribute.
// It works better.
@available(iOS 12.0, macOS 10.14, *)
open class NSRationalToDataTransformer : NSSecureUnarchiveFromDataTransformer {

    open override class func allowsReverseTransformation() -> Bool {
        return true
    }

    open override class func transformedValueClass() -> AnyClass {
        return NSRational.self
    }

    open override class var allowedTopLevelClasses: [AnyClass] {
        return [NSRational.self]
    }

    open override func transformedValue(_ value: Any?) -> Any? {

        guard let value = value else {
            return nil
        }

        return try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
    }

    open override func reverseTransformedValue(_ value: Any?) -> Any? {

        guard let data = value as? Data else {
            return nil
        }
        
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }

    public static func register() {
        let transformer = NSRationalToDataTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName.NSRationalToDataTransformer)
    }

}

extension NSValueTransformerName {

    public static let NSRationalToDataTransformer = NSValueTransformerName(rawValue: "NSRationalToDataTransformer")

}
