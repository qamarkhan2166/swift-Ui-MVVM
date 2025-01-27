//
//  MovieDetailUiState.swift
//  My First Swift
//
//  Created by Qamar khan on 1/26/25.
//

import Foundation

struct MovieDetailUiState {
    
    var isLoading: Bool = false
    var movieVideo: MovieVideo? = nil
    var showErrorAlert: Bool = false
    var errorAlertMessage: String = Constants.MovieDetailView.youtubeLinkError
    var isFavorite: Bool = false
    
    var youtubeLink: URL? {
        guard let key = movieVideo?.key else {
            return nil
        }
        return URL(string: "http://www.youtube.com/watch?v=\(key)")
    }
    
}

