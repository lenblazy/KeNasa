//
//  ImagesRepo.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

class ImagesRepo: ImagesRepoProtocol {
    
    private let cacheDataSource: CacheDataSource
    private let localDataSource: LocalDataSource
    private let remoteDataSource: RemoteDataSource
    
    var onFetchImages: (([Item]?, String?) -> Void)?
    
    init(cacheDataSource: CacheDataSource, localDataSource: LocalDataSource,remoteDataSource: RemoteDataSource){
        self.cacheDataSource = cacheDataSource
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchNasaImages() {
        fetchImagesFromCache()
    }
    
    func fetchImagesFromCache() {
        cacheDataSource.getImagesFromCache { [weak self] images in
            guard let images = images, images.count > 0 else {
                self?.fetchImagesFromDB()
                return
            }
            self?.onFetchImages?(images, nil)
        }
    }
    
    func fetchImagesFromDB(){
        localDataSource.getImagesFromDb { [weak self] images in
            guard let images = images, images.count > 0 else {
                self?.fetchImagesFromApi()
                return
            }
            self?.onFetchImages?(images, nil)
        }
    }
    
    func fetchImagesFromApi(){
        remoteDataSource.fetchNasaImages { [weak self] images, error in
            if let error = error {
                self?.onFetchImages?(nil, error)
            } else {
                self?.onFetchImages?(images, nil)
                self?.localDataSource.saveImagesToDb(list: images!)
            }
        }
    }
}
