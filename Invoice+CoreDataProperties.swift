//
//  Invoice+CoreDataProperties.swift
//  swift-charts
//
//  Created by 宇宣 Chen on 2022/8/24.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var customerNo: String?
    @NSManaged public var date: String?
    @NSManaged public var invoiceNo: String?

}

extension Invoice : Identifiable {

}
