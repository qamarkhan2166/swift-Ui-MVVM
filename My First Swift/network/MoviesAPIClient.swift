//
//  MoviesAPIClient.swift
//  My First Swift
//
//  Created by Qamar khan on 1/20/25.
//



import Foundation

/// Protocol to incapsulate the MoviesAPIClient functions for Unit tests and to use in ViewModels.
protocol MoviesAPIClientProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping ((Result<MoviesResponse, APIError>) -> Void))
    func fetchMovieDetails(id: Int, completion: @escaping ((Result<MovieDetailsResponse, APIError>) -> Void))
}

final class MoviesAPIClient: MoviesAPIClientProtocol {
    
    private let baseClient = BaseAPIClient()
    
    /// fetches the popular movies for a specific  page from Movie DB Server
    /// Parameter: Page to load content of specific page,
    /// Completion handler to return the date
    func fetchPopularMovies(page: Int, completion: @escaping ((Result<MoviesResponse, APIError>) -> Void)) {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            completion(.failure(APIError(errorMessage: "Authentication Failed")))
            return
        }
        guard let url = URL(string: "\(Constants.baseURL)/trending/movie/week?page=\(page)&api_key=\(apiKey)") else {
            completion(.failure(APIError(errorMessage: "Invalid Request")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let baseAPIClient = BaseAPIClient()
        baseAPIClient.execute(request) { (result: Result<MoviesResponse, APIError>) in
            completion(result)
        }
    }
    
    /// fetches the movie details against the movie ID from Movie DB Server
    func fetchMovieDetails(id: Int, completion: @escaping ((Result<MovieDetailsResponse, APIError>) -> Void)) {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            completion(.failure(APIError(errorMessage: "Authentication Failed")))
            return
        }
        guard let url = URL(string: "\(Constants.baseURL)/movie/\(id)/videos?api_key=\(apiKey)") else {
            completion(.failure(APIError(errorMessage: "Invalid Request")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let baseAPIClient = BaseAPIClient()
        baseAPIClient.execute(request) { (result: Result<MovieDetailsResponse, APIError>) in
            completion(result)
        }
    }
}
