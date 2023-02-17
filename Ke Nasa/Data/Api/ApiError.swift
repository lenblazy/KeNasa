//
//  ApiError.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 16/11/2022.
//

import Foundation

enum ApiError: LocalizedError, Equatable {
    
    case invalidResponseModel
    case emptyUrlString
    case requestFailed(description: String)
    
    var errorDescription: String? {
        switch self{
        case .requestFailed(let description):
            return description
        case .emptyUrlString, .invalidResponseModel:
            return ""
        }
    }
}
