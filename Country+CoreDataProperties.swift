//
//  Country+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/23.
//
//

import Foundation
import CoreData


extension Country {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
    return NSFetchRequest<Country>(entityName: "Country")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var countryToInvoice: Set<Invoice>?
  
  public var invoice: [Invoice] {
    let setOfInvoice = countryToInvoice
    return setOfInvoice!.sorted { $0.invoiceNo! > $1.invoiceNo! }
  }
  
}

// MARK: Generated accessors for countryToInvoice
extension Country {
  
  @objc(addCountryToInvoiceObject:)
  @NSManaged public func addToCountryToInvoice(_ value: Invoice)
  
  @objc(removeCountryToInvoiceObject:)
  @NSManaged public func removeFromCountryToInvoice(_ value: Invoice)
  
  @objc(addCountryToInvoice:)
  @NSManaged public func addToCountryToInvoice(_ values: NSSet)
  
  @objc(removeCountryToInvoice:)
  @NSManaged public func removeFromCountryToInvoice(_ values: NSSet)
  
}

extension Country : Identifiable {
  
}
