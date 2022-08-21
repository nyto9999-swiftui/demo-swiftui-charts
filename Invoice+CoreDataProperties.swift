//
//  Invoice+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/21.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var country: String?
    @NSManaged public var customerID: String?
    @NSManaged public var invoiceDate: String?
    @NSManaged public var invoiceNo: String?
    @NSManaged public var retails: NSOrderedSet?

}

// MARK: Generated accessors for retails
extension Invoice {

    @objc(insertObject:inRetailsAtIndex:)
    @NSManaged public func insertIntoRetails(_ value: Retail, at idx: Int)

    @objc(removeObjectFromRetailsAtIndex:)
    @NSManaged public func removeFromRetails(at idx: Int)

    @objc(insertRetails:atIndexes:)
    @NSManaged public func insertIntoRetails(_ values: [Retail], at indexes: NSIndexSet)

    @objc(removeRetailsAtIndexes:)
    @NSManaged public func removeFromRetails(at indexes: NSIndexSet)

    @objc(replaceObjectInRetailsAtIndex:withObject:)
    @NSManaged public func replaceRetails(at idx: Int, with value: Retail)

    @objc(replaceRetailsAtIndexes:withRetails:)
    @NSManaged public func replaceRetails(at indexes: NSIndexSet, with values: [Retail])

    @objc(addRetailsObject:)
    @NSManaged public func addToRetails(_ value: Retail)

    @objc(removeRetailsObject:)
    @NSManaged public func removeFromRetails(_ value: Retail)

    @objc(addRetails:)
    @NSManaged public func addToRetails(_ values: NSOrderedSet)

    @objc(removeRetails:)
    @NSManaged public func removeFromRetails(_ values: NSOrderedSet)

}

extension Invoice : Identifiable {

}
