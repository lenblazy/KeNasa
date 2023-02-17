//
//  CacheDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

protocol CacheDataSource{
    
    func getImagesFromCache(completion: @escaping ([Item]?) -> Void)
    
    func saveImagesToCache(images: [Item])
    
}
