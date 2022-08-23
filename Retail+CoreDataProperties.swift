//
//  Retail+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/24.
//
//

import Foundation
import CoreData


extension Retail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Retail> {
        return NSFetchRequest<Retail>(entityName: "Retail")
    }

    @NSManaged public var desc: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Double
    @NSManaged public var retailNo: String?
    @NSManaged public var retailToCountry: Country?

}

extension Retail : Identifiable {

}
