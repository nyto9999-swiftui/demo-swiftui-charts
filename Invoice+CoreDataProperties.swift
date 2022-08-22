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

    @NSManaged public var invoiceNo: String?
    @NSManaged public var date: String?
    @NSManaged public var customerNo: String?
    @NSManaged public var desc: String?
    @NSManaged public var quantity: String?
    @NSManaged public var price: String?
    @NSManaged public var country: String?
    @NSManaged public var retailNo: String?

}

extension Invoice : Identifiable {

}
