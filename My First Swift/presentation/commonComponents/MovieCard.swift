//
//  MovieCard.swift
//  My First Swift
//
//  Created by Qamar khan on 1/22/25.
//


import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            WebImage(url: URL(string: "\(Constants.baseImageURL)\(movie.posterPath)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
            
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.black).opacity(0.7)
                
                Text(String(format: DashboardStrings.movieAdult.localizedString, movie.adult ? DashboardStrings.movieAdultYes.localizedString : DashboardStrings.movieAdultNo.localizedString))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(0.7)
                
                Text(String(format: DashboardStrings.movieReleaseDate.localizedString, movie.releaseDate))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(0.7)
                
                Text(String(format: DashboardStrings.moviePopularity.localizedString, movie.popularity))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .opacity(0.7)
                
                HStack {
                    
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: index < Int(movie.voteAverage / 5) ? IconNames.filledStar.value : IconNames.nonFilledStar.value)
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    
                    Text(String(format: DashboardStrings.movieRating.localizedString, movie.voteAverage))
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.white)
        .cornerRadius(6)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Preview
struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie.placeholder)
    }
}

