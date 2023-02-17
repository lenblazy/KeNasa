//
//  MainResponse.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

//MARK: - Root response
struct MainResponse: Decodable{
    let collection: NasaCollection
}

//MARK: - Collection json
struct NasaCollection: Decodable{
    let items: [Item]
}

//MARK: - Single Nasa Item
struct Item: Decodable{
    let data: [ItemData]
    let links: [Link]
}

//MARK: - Single data for given item
struct ItemData: Decodable{
    var title: String
    var photographer: String?
    var date_created: String
    var description: String
}

//MARK: - Single link of the given item
struct Link: Decodable{
    let href: String
}
