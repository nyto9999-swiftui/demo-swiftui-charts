//
//  Retail+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/23.
//
//

import Foundation
import CoreData


extension Retail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Retail> {
        return NSFetchRequest<Retail>(entityName: "Retail")
    }

    @NSManaged public var retailNo: String?
    @NSManaged public var quantity: String?
    @NSManaged public var price: String?
    @NSManaged public var desc: String?
    @NSManaged public var retailToInvoice: Set<Invoice>?
  
  public var invoice: [Invoice] {
    let setOfInvoice = retailToInvoice
    return setOfInvoice!.sorted { $0.invoiceNo! > $1.invoiceNo! }
  }

}

// MARK: Generated accessors for retailToInvoice
extension Retail {

    @objc(addRetailToInvoiceObject:)
    @NSManaged public func addToRetailToInvoice(_ value: Invoice)

    @objc(removeRetailToInvoiceObject:)
    @NSManaged public func removeFromRetailToInvoice(_ value: Invoice)

    @objc(addRetailToInvoice:)
    @NSManaged public func addToRetailToInvoice(_ values: NSSet)

    @objc(removeRetailToInvoice:)
    @NSManaged public func removeFromRetailToInvoice(_ values: NSSet)

}

extension Retail : Identifiable {

}
