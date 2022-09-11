//
//  ImagesListVM.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: - Represents the whole screen for images list
class ImagesListViewModel{
    
    // empty list of viewmodels
    let imageVms: [ImageViewModel]
    
    init(_ images: [Item]){
        self.imageVms = images.compactMap({ image in
            ImageViewModel.init(image)
        })
    }
    
}

//MARK: - Represent a given image
extension ImagesListViewModel{
    
    func imageAt(_ index: Int) -> ImageViewModel{
        return self.imageVms[index]
    }
    
}

//MARK: - Represents single item in the list, initialize the object
struct ImageViewModel{
    
    let item: Item
    
    init(_ item: Item){
        self.item = item
    }
    
}

//MARK: - Initialize imageviewmodel
extension ImageViewModel{
    
    var link: Link {
        return item.links[0]
    }
    
    var imageURL: Observable<String>{
        return Observable<String>.just(link.href)
    }
    
    var data: ItemData{
        return item.data[0]
    }
    
    var desc: Observable<String>{
        return Observable<String>.just(data.description)
    }
    
    var name: String{
        return data.photographer ?? "Not found"
    }
    
    var date: String{
        return data.date_created.formatDateFromString()
    }
    
    var header: Observable<String>{
        return Observable<String>.just(data.title)
    }
    
    var subHeader: Observable<String>{
        return Observable<String>.just("\(name) | \(date)")
    }
}
