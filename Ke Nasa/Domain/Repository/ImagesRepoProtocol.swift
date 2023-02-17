//
//  ImagesRepositoryProtocol.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

protocol ImagesRepoProtocol{
    
    var onFetchImages: (([Item]?, String?) -> Void)? { get set }
    
    func fetchNasaImages()
    
}
