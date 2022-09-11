//
//  ImagesListVM.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

//MARK: - Represents the whole screen for images list
class ImagesListViewModel{
    
    // empty list of viewmodels
    var imageVms: [ImageViewModel] = [ImageViewModel]()
    
    //MARK: - make request to load images from NASA
    func load(){
        fetchNasaImages()
    }
    
    private func fetchNasaImages(){
        WebService().loadImages { status, errorString, items in
            if status{
                //
                if let items = items {
                    //populating imageviemodels list
                    self.imageVms = items.map { item in
                        ImageViewModel.init(item: item)
                    }
                }
                //
            }else{
                //
                print(errorString)
                //
            }
        }
    }
    
}

//
//
//MARK: - Represents single item in the list
struct ImageViewModel{
    
    let item: Item
    
    //MARK: -Link from links array
    var link: Link{
        return item.links[0]
    }
    
    var imageURL: String{
        return link.href
    }
    
    //MARK: - Data from data array
    var data: ItemData{
        return item.data[0]
    }
    
    var desc: String{
        return data.description
    }
    
    var name: String{
        return data.photographer
    }
    
    var date: String{
        return data.date_created.formatDateFromString()
    }
    
    var header: String{
        return data.title
    }
    
    var subHeader: String{
        return "\(name) | \(date)"
    }
    
}
