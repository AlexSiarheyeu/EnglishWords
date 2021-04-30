//
//  URLConstructor.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/6/21.
//

import Foundation


enum URLConstructor: String {
    
    case baseURL = "https://wordsapiv1.p.rapidapi.com/words/"
    
    enum Endpoint: String {
        case definitions = "/definitions"
        case examples = "/examples"
    }
    
    enum Headers: String {
        case apiKey = "636f23081amsh2f4297c88b9697dp125ce2jsnd3564c39cdf4"
        case apiHost = "wordsapiv1.p.rapidapi.com"
    }
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    static func createRequestWith(word: String, with: URLConstructor.Endpoint?) -> URLRequest {
        
        let headers = [
            "x-rapidapi-key": URLConstructor.Headers.apiKey.rawValue,
            "x-rapidapi-host": URLConstructor.Headers.apiHost.rawValue
        ]
        
        var urlString = ""
        let newWord = word
        
        urlString += URLConstructor.baseURL.rawValue
        urlString += newWord.replacingOccurrences(of: " ", with: "")
        urlString += with?.rawValue ?? ""
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = URLConstructor.HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
        
    }
}
