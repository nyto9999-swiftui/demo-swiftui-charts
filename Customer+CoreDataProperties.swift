//
//  Customer+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/22.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: UUID?
    @NSManaged public var customerNo: String?
    @NSManaged public var customerToInvoice: NSSet?
    @NSManaged public var customerToRetail: NSSet?

}

// MARK: Generated accessors for customerToInvoice
extension Customer {

    @objc(addCustomerToInvoiceObject:)
    @NSManaged public func addToCustomerToInvoice(_ value: Invoice)

    @objc(removeCustomerToInvoiceObject:)
    @NSManaged public func removeFromCustomerToInvoice(_ value: Invoice)

    @objc(addCustomerToInvoice:)
    @NSManaged public func addToCustomerToInvoice(_ values: NSSet)

    @objc(removeCustomerToInvoice:)
    @NSManaged public func removeFromCustomerToInvoice(_ values: NSSet)

}

// MARK: Generated accessors for customerToRetail
extension Customer {

    @objc(addCustomerToRetailObject:)
    @NSManaged public func addToCustomerToRetail(_ value: Retail)

    @objc(removeCustomerToRetailObject:)
    @NSManaged public func removeFromCustomerToRetail(_ value: Retail)

    @objc(addCustomerToRetail:)
    @NSManaged public func addToCustomerToRetail(_ values: NSSet)

    @objc(removeCustomerToRetail:)
    @NSManaged public func removeFromCustomerToRetail(_ values: NSSet)

}

extension Customer : Identifiable {

}
