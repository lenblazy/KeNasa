//
//  CacheDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

class CacheDataSourceImpl: CacheDataSource{
    
    private lazy var imagesList = [Item]()
    
    func getImagesFromCache(completion: @escaping ([Item]?) -> Void) {
        completion(imagesList)
    }
    
    func saveImagesToCache(images: [Item]) {
        imagesList.removeAll()
        imagesList.append(contentsOf: images)
    }
    
}
