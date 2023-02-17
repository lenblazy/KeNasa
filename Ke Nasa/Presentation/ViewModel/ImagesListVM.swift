//
//  ImagesListVM.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

//MARK: - Represents the whole screen for images list
class ImagesListViewModel {
    
    //closures controlling ui
    var reloadCollectionViewClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var performSegue: (() -> Void)?
    
    private var repository: ImagesRepoProtocol
    
    init(repository: ImagesRepoProtocol) {
        self.repository = repository
        self.repository.fetchNasaImages()
    }
    
    var selectedArticle: ImageViewModel?
    
    var imageViewModels = [ImageViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return imageViewModels.count
    }
    
    
    
    func populateData() {
        self.isLoading = true
        self.repository.onFetchImages = { [weak self] items, error in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            if let error = error {
                self?.alertMessage = error
            } else {
                strongSelf.imageViewModels = items!.map({ item in
                    ImageViewModel(item: item)})
            }
        }
        self.repository.fetchNasaImages()
        
        
    }
    
    func getCellViewModel(at indexPath: IndexPath ) -> ImageViewModel {
        return imageViewModels[indexPath.row]
    }
    
    func userPressed(at indexPath: IndexPath ){
        self.selectedArticle = self.imageViewModels[indexPath.row]
        self.performSegue?()
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
