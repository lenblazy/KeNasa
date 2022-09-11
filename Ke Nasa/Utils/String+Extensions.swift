//
//  String+Extensions.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation

//MARK: - Extension for strings
extension String{
    
    //MARK: - Formats strings in //2009-12-20T00:00:00Z to //20 Mar, 2002
    func formatDateFromString() -> String {
        
        //2009-12-20T00:00:00Z
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = inputFormatter.date(from: self) {
            
            //20 Mar, 2002
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM, yyyy"
            
            return outputFormatter.string(from: date)
        }
        
        return self
    }
    
}
