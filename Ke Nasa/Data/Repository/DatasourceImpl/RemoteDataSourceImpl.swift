//
//  RemoteDataSource.swift
//  Ke Nasa
//
//  Created by Lennox Mwabonje on 17/02/2023.
//

import Foundation

class RemoteDataSourceImpl: RemoteDataSource {
    
    private var webservice: WebServiceProtocol
    
    init(webservice: WebServiceProtocol){
        self.webservice = webservice
    }
    
    func fetchNasaImages(completion: @escaping ([Item]?, String?) -> Void) {
        webservice.fetchNasaImages { mainResponse, apiError in
            if let error = apiError {
                completion(nil, error.localizedDescription)
            } else {
                completion(mainResponse?.collection.items, nil)
            }
        }
        
    }
    
}
