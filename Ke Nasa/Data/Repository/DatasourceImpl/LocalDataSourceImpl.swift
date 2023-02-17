//
//  LocalDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation
import CoreData
import UIKit

class LocalDataSourceImpl: LocalDataSource{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImagesToDb(list: [Item]) {
        
        //
        list.forEach { [weak self] item in
            guard let strongSelf = self else { return }
            // Item
            let dbItem = DbItem(context: strongSelf.context)
            
            item.links.forEach { link in
                guard let strongSelf = self else { return }
                let dbLink = DbLink(context: strongSelf.context)
                dbLink.db_href = link.href
                dbItem.addToLinks(dbLink)
            }
            
            item.data.forEach { itemData in
                guard let strongSelf = self else { return }
                let dbItemData = DbItemData(context: strongSelf.context)
                dbItemData.db_date_created = itemData.date_created
                dbItemData.db_title = itemData.title
                dbItemData.db_description = itemData.description
                dbItemData.db_photographer = itemData.photographer
                
                dbItem.addToItems(dbItemData)
            }
            
        }
        
        try? context.save()
        
    }
    
    func getImagesFromDb(completion: @escaping ([Item]?) -> Void) {
        do{
            let dbItems = try context.fetch(DbItem.fetchRequest())
            let items: [Item]? = dbItems.map { dbItem in
                
                let itemDataSet = dbItem.value(forKey: "items") as? NSSet
                let itemDataArray = itemDataSet?.allObjects as? [DbItemData]
               
                
                let itemData = itemDataArray!.compactMap({ dbItem in
                    ItemData(title: dbItem.db_title!, photographer: dbItem.db_photographer, date_created: dbItem.db_date_created!, description: dbItem.db_description! )
                })
                
                let linkDataSet = dbItem.value(forKey: "links") as? NSSet
                let linkDataArray = linkDataSet?.allObjects as? [DbLink]
                
                let links = linkDataArray!.compactMap { dbLink in
                    Link(href: dbLink.db_href!)
                }
                
                
                let item = Item(data: itemData, links: links)
                return item
            }
            completion(items)
        }catch{
            completion(nil)
        }
    }
    
}
