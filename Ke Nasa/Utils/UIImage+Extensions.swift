//
//  UIImage+Extensions.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 18/11/2022.
//

import UIKit

extension UIImage {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) -> ()) {
        
        guard let url = URL(string: endPoint) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCache.setObject(loadedImage, forKey: endPoint as AnyObject)
                    }
                }
            }
        }
    }
}

