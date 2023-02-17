//
//  WebService.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 16/11/2022.
//

import Foundation

protocol WebServiceProtocol {
    func fetchNasaImages(completion: @escaping (MainResponse?, ApiError?) -> Void)
}

struct WebService: WebServiceProtocol {
    
    private let urlString: String
    private let urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = URLSession.shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func fetchNasaImages(completion: @escaping (MainResponse?, ApiError?) -> Void) {
        
        guard let url = URL(string: self.urlString) else {
            completion(nil, ApiError.emptyUrlString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, ApiError.requestFailed(description: error.localizedDescription))
                return
            }
            
            if let data = data, let responseDataModel = try? JSONDecoder().decode(MainResponse.self, from: data) {
                completion(responseDataModel, nil)
            } else {
                completion(nil, ApiError.invalidResponseModel)
            }
        }
        
        dataTask.resume()
    }
    
}
