//
//  DbItemData+CoreDataProperties.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//
//

import Foundation
import CoreData


extension DbItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DbItemData> {
        return NSFetchRequest<DbItemData>(entityName: "DbItemData")
    }

    @NSManaged public var db_photographer: String?
    @NSManaged public var db_date_created: String?
    @NSManaged public var db_title: String?
    @NSManaged public var db_description: String?
    @NSManaged public var itemParent: DbItem?

}

extension DbItemData : Identifiable {

}
