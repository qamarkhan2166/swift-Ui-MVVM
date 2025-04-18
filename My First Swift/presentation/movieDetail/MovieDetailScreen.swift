//
//  MovieDetailScreen.swift
//  My First Swift
//
//  Created by Qamar khan on 1/26/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailScreen: View {
    
    let movie: Movie
    @StateObject private var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Movie Poster and Header
                ZStack(alignment: .bottomLeading) {
                    WebImage(url: URL(string: "\(Constants.baseImageURL)\(movie.posterPath)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        .frame(height: 400)
                        .clipped()
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 150)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: IconNames.filledStar.value)
                                    .foregroundColor(.yellow)
                                    .font(.subheadline)
                                Text("\(String(format: "%.1f", movie.voteAverage))(\(movie.voteCount))")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Text(movie.title)
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        }
                        Spacer()
                        FavoriteButton(isFav: viewModel.uiState.isFavorite) {
                            viewModel.toggleFavorite()
                        }
                    }
                    .padding()
                }
                
                // Movie Information
                VStack(alignment: .leading, spacing: 8) {
                    Text(String(format: DashboardStrings.movieAdult.localizedString, movie.adult ? DashboardStrings.movieAdultYes.localizedString : DashboardStrings.movieAdultNo.localizedString))
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Text(String(format: DashboardStrings.movieReleaseDate.localizedString, movie.releaseDate))
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    HStack(spacing: 8) {
                        GenreTagView(genre: DashboardStrings.genreDrama.localizedString)
                        GenreTagView(genre: DashboardStrings.genreSciFi.localizedString)
                        GenreTagView(genre: DashboardStrings.genreAction.localizedString)
                    }
                }
                .padding(.horizontal)
                
                // Movie Description
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(Color.black.opacity(0.7))
                    .lineLimit(10)
                    .padding(.horizontal)
                
                // Watch Button
                PrimaryButton(
                    title: DashboardStrings.watchTrailer.localizedKey,
                    isEnabled: true
                ) {
                    let youtubeLink = viewModel.uiState.youtubeLink
                    if let link = youtubeLink {
                        UIApplication.shared.open(link, options: [:], completionHandler: nil)
                    } else {
                        print(DashboardStrings.youtubeLinkNotAvailable.localizedKey)
                    }
                }.padding(.horizontal).padding(.bottom, 20)
                
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .alert(isPresented: $viewModel.uiState.showErrorAlert) {
                Alert(title: Text(DashboardStrings.fetchDetailsFailed.localizedKey), message: Text(viewModel.uiState.errorAlertMessage))
            }
            .overlay {
                if viewModel.uiState.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.4))
                }
            }
            .onAppear() {
                viewModel.fetchMovieDetails(movieId: movie.id)
            }
        }
    }
}

// MARK: - Tag View
struct GenreTagView: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .font(.caption)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.gray.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(5)
    }
}

// MARK: - Preview
struct MovieDetailScreen_Previews_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen(movie: .placeholder)
    }
}

