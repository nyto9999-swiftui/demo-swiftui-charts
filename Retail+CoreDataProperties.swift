//
//  Retail+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/22.
//
//

import Foundation
import CoreData


extension Retail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Retail> {
        return NSFetchRequest<Retail>(entityName: "Retail")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var price: String?
    @NSManaged public var quantity: String?
    @NSManaged public var retailNo: String?
    @NSManaged public var invoice: Invoice?
    @NSManaged public var retailToCustomer: NSSet?

}

// MARK: Generated accessors for retailToCustomer
extension Retail {

    @objc(addRetailToCustomerObject:)
    @NSManaged public func addToRetailToCustomer(_ value: Customer)

    @objc(removeRetailToCustomerObject:)
    @NSManaged public func removeFromRetailToCustomer(_ value: Customer)

    @objc(addRetailToCustomer:)
    @NSManaged public func addToRetailToCustomer(_ values: NSSet)

    @objc(removeRetailToCustomer:)
    @NSManaged public func removeFromRetailToCustomer(_ values: NSSet)

}

extension Retail : Identifiable {

}
