//
//  BaseViewModel.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

import Foundation

class BaseViewModel: ObservableObject {
    let coordinator = NavigationCoordinator.shared
    
    // Common functionality for all view models
    func handleError() {
        // Error handling logic
    }
}
