//
//  MovieDetailViewModel.swift
//  My First Swift
//
//  Created by Qamar khan on 1/26/25.
//

import Foundation
import Combine

final class MovieDetailViewModel: BaseViewModel {
    
    // MARK: - Published Properties
    @Published var uiState: MovieDetailUiState = .init()
    
    private let apiClient: MoviesAPIClientProtocol
    
    // MARK: - Initialization
    init(apiClient: MoviesAPIClientProtocol = MoviesAPIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchMovieDetails(movieId: Int) {
        uiState.isLoading = true
        apiClient.fetchMovieDetails(id: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.handleSuccess(response)
                
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }

    private func handleSuccess(_ response: MovieDetailsResponse) {
        self.uiState.isLoading = false
        if let details = response.results.first {
            self.uiState.movieVideo = details
        } else {
            showError(Constants.MovieDetailView.youtubeLinkError)
        }
    }

    private func handleError(error: Error) {
        print("Failed to fetch movie details: \(error.localizedDescription)")
        showError(Constants.MovieDetailView.youtubeLinkError)
    }

    private func showError(_ message: String) {
        self.uiState.isLoading = false
        self.uiState.errorAlertMessage = message
        self.uiState.showErrorAlert = true
    }
    
    func toggleFavorite() {
        uiState.isFavorite.toggle()
    }
    
}
