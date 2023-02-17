//
//  LocalDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

protocol LocalDataSource{
    
    func getImagesFromDb(completion: @escaping ([Item]?) -> Void)
    
}
