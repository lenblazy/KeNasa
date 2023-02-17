//
//  DbItem+CoreDataProperties.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//
//

import Foundation
import CoreData


extension DbItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DbItem> {
        return NSFetchRequest<DbItem>(entityName: "DbItem")
    }

    @NSManaged public var items: NSSet?
    @NSManaged public var links: NSSet?

}

// MARK: Generated accessors for items
extension DbItem {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: DbItemData)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: DbItemData)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for links
extension DbItem {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: DbLink)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: DbLink)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}

extension DbItem : Identifiable {

}
