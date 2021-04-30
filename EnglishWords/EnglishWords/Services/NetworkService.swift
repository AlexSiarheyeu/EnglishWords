//
//  DownloadService.swift
//  EnglishWords
//
//  Created by Alexey Sergeev on 4/5/21.
//

import Foundation


final public class NetworkService {
    
    init() {}

    public func requestInformationAbout(word: String, _ completion: @escaping (Result<Word, Error>) -> Void)  {
        
        var model = Word()
        let semaphore = DispatchSemaphore(value: 1)
        
        let requestForDefinitions = URLConstructor.createRequestWith(word: word, with: .definitions)
        semaphore.wait()
        getInfoAboutWord(request: requestForDefinitions, decode: Definition.self) { result in
            
            switch result {
                case .success(let value):
                    model.definition = value
                    semaphore.signal()
                case .failure(let error):
                    semaphore.signal()
                    completion(.failure(error))
            }
        }
            
        let requestForExamples = URLConstructor.createRequestWith(word: word, with: .examples)
        semaphore.wait()
        getInfoAboutWord(request: requestForExamples, decode: Example.self) { (result) in
            
            switch result {
                case .success(let value):
                    model.example = value
                    semaphore.signal()
                case .failure(let error):
                    semaphore.signal()
                    completion(.failure(error))
            }
        }
        
        semaphore.wait()
        completion(.success(model))
        semaphore.signal()

    }
    
   private func getInfoAboutWord<T: Decodable>(request: URLRequest,
                                               decode: T.Type,
                                               _ completion: @escaping (Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { [weak self] data, response, error in
                                    
            guard let self = self else { return }
                                    
            guard let data = data else {
                completion(.failure(HTTPError.nonHTTPResponse))
                return
            }
            
            guard error == nil else {
                if let error = error  {
                    completion(.failure(HTTPError.error(error as NSError)))
                }
                return
            }
           
            if let result = self.decode(typeOf: decode.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(ViewError.wordIsNotExist))
            }
            
        }).resume()
    }

    private func decode<T: Decodable> (typeOf: T.Type,
                                       from data: Data?) -> T? {
        
        guard let data = data else {  return nil }
        let response = try? JSONDecoder().decode(typeOf.self, from: data)
        return response
    }
}

