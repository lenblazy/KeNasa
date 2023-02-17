//
//  RemoteDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

protocol RemoteDataSource {
    
    func fetchNasaImages(completion: @escaping ([Item]?, String?) -> Void)
    
}


