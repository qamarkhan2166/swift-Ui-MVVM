//
//  DashboardScreen.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

import SDWebImageSwiftUI
import SwiftUI

struct DashboardScreen: View {
    
    @StateObject private var viewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        
        Group {
            switch viewModel.uiState.loadingState {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            case .loaded:
                movieListView
                
            case .error(_):
                ErrorView(errorMessage: viewModel.uiState.errorAlert?.message ?? "") {
                    viewModel.fetchPopularMovies()
                }
            }
        }
        .navigationTitle(DashboardStrings.DashboardTitle.localizedKey)
        .searchable(text: $viewModel.uiState.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: viewModel.uiState.searchText) { oldValue, newValue in
            if oldValue != newValue {
                viewModel.filterData(string: newValue)
            }
        }
        .onAppear {
            viewModel.fetchPopularMovies()
        }
        
    }
    
    private var movieListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.uiState.movies) { movie in
                    NavigationLink(destination: MovieDetailScreen.init(movie: movie)) {
                        MovieCard(movie: movie)
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentMovieId: movie.id)
                            }
                    }
                    
                }
            }
            .padding(.horizontal)
        }
    }
    
}

// MARK: - Preview
struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}

extension View {
    func toAnyView() -> AnyView { AnyView(self) }
}
