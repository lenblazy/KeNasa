//
//  ImagesListVM.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

protocol ImageListUI {
    func showLoader()
    func hideLoader()
    func showError(errorMsg: String)
    func refreshList()
}

//MARK: - Represents the whole screen for images list
class ImagesListViewModel {
    
    private var webService: WebService
    var imageViewModels = [ImageViewModel]()
    
    var ui: ImageListUI?
    
    init(webservice: WebService) {
        self.webService = webservice
        populateData()
    }
    
    private func populateData() {
        ui?.showLoader()
        self.webService.fetchNasaImages { [weak self] response, error in
            DispatchQueue.main.async {
                self?.ui?.hideLoader()
                if error != nil{
                    self?.ui?.showError(errorMsg: error?.localizedDescription ?? "An error occurred")
                } else {
                    self?.imageViewModels = response!.collection.items.map({ item in
                        ImageViewModel(item: item)
                    })
                    self?.ui?.refreshList()
                }
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
    
    var header: String {
        return data.title
    }
    
    var author: String {
        return data.photographer ?? ""
    }
    
    var date: String {
        return data.date_created
    }
    
    var content: String {
        return data.description
    }
    
    var imgLink: String {
        return item.links[0].href
    }
    
    var subHeader: String {
        return "\(author) | \(AppUtil().formatDateString(date))"
    }
    
}
