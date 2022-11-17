//
//  AppUtil.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 16/11/2022.
//

import Foundation

struct AppUtil {
    
    func formatDateString(_ input: String, format: String = "yyyy-MM-dd'T'HH:mm:ss'Z'" ) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
        
        guard let date = inputFormatter.date(from: input) else {
            return ""
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM, yyyy" //20 Mar, 2002
        
        return outputFormatter.string(from: date)
    }
    
}
