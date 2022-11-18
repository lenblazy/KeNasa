//
//  UIImageView+Extensions.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 18/11/2022.
//

import Foundation
import UIKit

extension UIImageView{
    
    func loadFrom(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = loadedImage
                    }
                }
            }
        }
        
    }
    
}
