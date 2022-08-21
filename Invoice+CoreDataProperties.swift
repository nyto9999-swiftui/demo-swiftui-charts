//
//  Invoice+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/22.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: UUID?
    @NSManaged public var invoiceNo: String?
    @NSManaged public var invoiceToCustomer: NSSet?
    @NSManaged public var retails: NSSet?

}

// MARK: Generated accessors for invoiceToCustomer
extension Invoice {

    @objc(addInvoiceToCustomerObject:)
    @NSManaged public func addToInvoiceToCustomer(_ value: Customer)

    @objc(removeInvoiceToCustomerObject:)
    @NSManaged public func removeFromInvoiceToCustomer(_ value: Customer)

    @objc(addInvoiceToCustomer:)
    @NSManaged public func addToInvoiceToCustomer(_ values: NSSet)

    @objc(removeInvoiceToCustomer:)
    @NSManaged public func removeFromInvoiceToCustomer(_ values: NSSet)

}

// MARK: Generated accessors for retails
extension Invoice {

    @objc(addRetailsObject:)
    @NSManaged public func addToRetails(_ value: Retail)

    @objc(removeRetailsObject:)
    @NSManaged public func removeFromRetails(_ value: Retail)

    @objc(addRetails:)
    @NSManaged public func addToRetails(_ values: NSSet)

    @objc(removeRetails:)
    @NSManaged public func removeFromRetails(_ values: NSSet)

}

extension Invoice : Identifiable {

}
