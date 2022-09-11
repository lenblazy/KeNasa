//
//  WebService.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

class WebService{
    
    //MARK: - loads images from nasa api
    func loadImages(completion: @escaping (Bool, String?, [Item]?) -> Void) {
        
        //
        guard let url = URL(string: "https://images-api.nasa.gov/search?q=%22%22") else {
            completion(false, "URL is invalid", nil)
            return
        }
        //
        URLSession.shared.dataTask(with: url) { data, response, error in
            //
            guard let safeData = data,  error == nil else{
                completion(false, "A Network Error Occurred", nil)
                return
            }
            //
            do{
                let res = try JSONDecoder().decode(MainResponse.self, from: safeData)
                let items = res.collection.items
                completion(true, "Images retrieved successfully", items)
            }catch{
                completion(false, "\(error.localizedDescription)", nil)
            }
            //
        }.resume()
        //
        
    }
    
    
}
