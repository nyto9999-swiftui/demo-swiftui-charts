//
//  Retail+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/21.
//
//

import Foundation
import CoreData


extension Retail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Retail> {
        return NSFetchRequest<Retail>(entityName: "Retail")
    }

    @NSManaged public var desc: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var stockCode: String?
    @NSManaged public var unitPrice: Float
    @NSManaged public var invoice: Invoice?

}

extension Retail : Identifiable {

}
