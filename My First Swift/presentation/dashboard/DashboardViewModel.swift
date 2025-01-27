//
//  DashboardViewModel.swift
//  My First Swift
//
//  Created by Qamar khan on 1/20/25.
//

import Foundation
import Combine

final class DashboardViewModel: BaseViewModel {
    // MARK: - Published Properties
    
    @Published var uiState: DashboardUiState = .init()
    
    // MARK: - Private Properties
    
    private let apiClient: MoviesAPIClientProtocol
    private var totalPages: Int = 1
    private var currentPage: Int = 1
    private var originalData: [Movie] = []
    
    private var isSearching: Bool {
        uiState.movies.count != originalData.count
    }
    
    // MARK: - Initialization
    
    init(apiClient: MoviesAPIClientProtocol = MoviesAPIClient()) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods
    
    func fetchPopularMovies() {
        apiClient.fetchPopularMovies(page: currentPage) { result in
            self.uiState.loadingState = .loaded
            switch result {
            case .success(let success):
                self.originalData.append(contentsOf: success.results)
                self.totalPages = success.totalPages
                self.uiState.movies.append(contentsOf: success.results)
                print(success.results)
            case .failure(let failure):
                self.uiState.loadingState = .error(failure)
                self.uiState.errorAlert = .init(
                    message: failure.localizedDescription,
                    isShowing: true
                )
                self.uiState.showErrorAlert = true
            }
        }
    }
    
    /// Filters the movie list based on the search string
    func filterData(string: String) {
        guard !string.isEmpty else {
            self.uiState.movies = originalData
            return
        }
        
        self.uiState.movies = originalData.filter {
            $0.title.lowercased().contains(string.lowercased())
        }
    }
    
    /// Checks and loads more data if the user reaches the end of the list
    func loadMoreIfNeeded(currentMovieId: Int) {
        guard !isSearching,
              currentMovieId == originalData.last?.id,
              currentPage < totalPages else {
            return
        }
        
        currentPage += 1
        fetchPopularMovies()
    }
}
