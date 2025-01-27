//
//  Movie.swift
//  MovieFinder
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview, posterPath: String
    let mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MovieDetailsResponse: Codable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Codable {
    let name: String
    let key: String
}


extension Movie {
    static var placeholder: Movie {
        Movie(
            adult: false,
            backdropPath: nil,
            id: 0,
            title: "Placeholder Title",
            originalLanguage: "en",
            originalTitle: "Placeholder Original Title",
            overview: "This is a placeholder overview.",
            posterPath: "",
            mediaType: "movie",
            genreIDS: [],
            popularity: 0.0,
            releaseDate: "",
            video: false,
            voteAverage: 0.0,
            voteCount: 3
        )
    }
}
