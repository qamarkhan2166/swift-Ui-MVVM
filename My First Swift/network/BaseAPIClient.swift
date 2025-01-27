//
//  BaseAPIClient.swift
//  My First Swift
//
//  Created by Qamar khan on 1/20/25.
//

import Foundation

protocol APIClientProtocol {
    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping (Result<T, APIError>) -> Void)
}

/// BaseAPIClient contains the base code for api calls
class BaseAPIClient: APIClientProtocol {
    
    /// generic method to call the api from any api client
    /// Paramter: accepts URLRequest to call to the server
    /// callback: callback completion to return any data on Main thread
    /// The data will always be returned on the main thread so don't need to use Main Thread for any completion for this function.
    func execute<T: Decodable>(_ request: URLRequest, callback: @escaping (Result<T, APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    callback(.failure(APIError(errorMessage: "No data returned from API")))
                }
                return
            }
            var response: T?
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                response = try decoder.decode(T.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let response else {
                DispatchQueue.main.async {
                    callback(.failure(APIError(errorMessage: "No data returned from API")))
                }
                return
            }
            DispatchQueue.main.async {
                callback(.success(response))
            }
        }
        
        task.resume()
    }
}
