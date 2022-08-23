//
//  Country+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/24.
//
//

import Foundation
import CoreData


extension Country {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
    return NSFetchRequest<Country>(entityName: "Country")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var countryToRetail: Set<Retail>?
  public var retails: [Retail] {
    let setOfInvoice = countryToRetail
    return setOfInvoice!.sorted { $0.retailNo! > $1.retailNo! }
  }
}

// MARK: Generated accessors for countryToRetail
extension Country {
  
  @objc(addCountryToRetailObject:)
  @NSManaged public func addToCountryToRetail(_ value: Retail)
  
  @objc(removeCountryToRetailObject:)
  @NSManaged public func removeFromCountryToRetail(_ value: Retail)
  
  @objc(addCountryToRetail:)
  @NSManaged public func addToCountryToRetail(_ values: NSSet)
  
  @objc(removeCountryToRetail:)
  @NSManaged public func removeFromCountryToRetail(_ values: NSSet)
  
}

extension Country : Identifiable {
  
}
