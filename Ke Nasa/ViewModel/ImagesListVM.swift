//
//  ImagesListVM.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

//MARK: - Represents the whole screen for images list
class ImagesListViewModel {
    
    private var webService: WebService
    private var imageViewModels = [ImageViewModel]()
    
    init(webservice: WebService) {
        self.webService = webservice
        populateData()
    }
    
    private func populateData(){
        //TODO: Show Loader
        self.webService.fetchNasaImages { [weak self] response, error in
            //TODO: Dismiss Loader
            if error != nil{
                //TODO: Show error
            } else {
                self?.imageViewModels = response!.collection.items.map({ item in
                    ImageViewModel(item: item)
                })
            }
        }
    }
}


//MARK: - ImageViewModel
struct ImageViewModel {
    
    let item: Item
    let data: ItemData
    
    init(item: Item){
        self.item = item
        self.data = item.data[0]
    }
    
//    let photographer: String?
//    let date_created: String
//    let description: String
//    let href: String
    
//    var data: ItemData {
//        return item.data[0]
//    }
    
    var header: String {
        return data.title
    }
    
    var author: String {
        return data.photographer ?? ""
    }
    
}
