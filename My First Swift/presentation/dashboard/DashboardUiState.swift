//
//  DashboardUiState.swift
//  My First Swift
//
//  Created by Qamar khan on 1/20/25.
//

import Foundation

struct DashboardUiState {
    
    var isLoading: Bool = false
    var movies: [Movie] = []
    var showErrorAlert: Bool = false
    var loadingState: DashboardLoadingState = .loading
    var searchText: String = ""
    var errorAlert: AlertState?
    
    struct AlertState {
        let message: String
        let isShowing: Bool
    }
    
}

enum DashboardLoadingState {
    case loading
    case loaded
    case error(Error)
}
