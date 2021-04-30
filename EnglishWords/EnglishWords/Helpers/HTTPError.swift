//
//  HTTPError.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import Foundation


public enum HTTPError: Error, Equatable {
    case nonHTTPResponse
    case error(NSError)
    case failedToDecode
    case requestFailed(Int)
    case networkingError(URLError)
    
    var description: String {
        switch self {
        case .nonHTTPResponse: return "Non HTTP URL Response Received"
        case .requestFailed(let status): return "Received HTTP \(status)"
        case .networkingError(let error): return "Networking error: \(error)"
        case .error(let error): return "Error: \(error)"
        case .failedToDecode: return "Failed to decode your type of model"
        }
    }
}


enum ViewError: Error {
    case wordIsNotExist
    
    var description: String {
        switch self {
        case .wordIsNotExist: return "Word is not exist"
        }
    }
}
