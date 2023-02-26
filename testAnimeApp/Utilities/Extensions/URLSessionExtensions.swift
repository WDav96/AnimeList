//
//  URLSessionExtensions.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import Foundation

extension URLSession {
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(url: URL?, expecting: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void ) {
        guard let url = url else {
            completionHandler(.failure(CustomError.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    completionHandler(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completionHandler(.success(result))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
        
    }
    
}
