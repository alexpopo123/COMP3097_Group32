//
//  Item+CoreDataProperties.swift
//  comp3097_group32
//
//  Created by Loman Chan Shum on 2023-03-23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var group: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var urgency: String?
    @NSManaged public var unitPrice: Double
    @NSManaged public var createdDate: Date?
    @NSManaged public var purchasedDate: Date?

}

extension Product : Identifiable {

}
