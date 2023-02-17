//
//  LocalDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation
import CoreData

class LocalDataSourceImpl: LocalDataSource{
    
    let context = NSManagedObjectContext()
    
    func saveImagesToDb(list: [Item]) {
        //
        list.forEach { [weak self] item in
            guard let strongSelf = self else { return }
            // Item
            var dbItem = DbItem(context: strongSelf.context)
            
            item.links.forEach { link in
                let dbLink = DbLink()
                dbLink.db_href = link.href
                dbItem.addToLinks(dbLink)
            }
            
            item.data.forEach { itemData in
                let dbItemData = DbItemData()
                dbItemData.db_date_created = itemData.date_created
                dbItemData.db_title = itemData.title
                dbItemData.db_description = itemData.description
                dbItemData.db_photographer = itemData.photographer
                
                dbItem.addToItems(dbItemData)
            }
            
        }
        
        try! context.save()
        
    }
    
    func getImagesFromDb(completion: @escaping ([Item]?) -> Void) {
        
    }
    
}
