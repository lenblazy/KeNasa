//
//  DbLink+CoreDataProperties.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//
//

import Foundation
import CoreData


extension DbLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DbLink> {
        return NSFetchRequest<DbLink>(entityName: "DbLink")
    }

    @NSManaged public var db_href: String?
    @NSManaged public var linkParent: DbItem?

}

extension DbLink : Identifiable {

}
