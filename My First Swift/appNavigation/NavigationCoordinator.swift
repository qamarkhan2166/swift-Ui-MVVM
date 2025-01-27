//
//  NavigationCoordinator.swift
//  My First Swift
//
//  Created by Qamar khan on 1/13/25.
//

import Foundation
import SwiftUI

// MARK: - Navigation Coordinator
/**
 The `NavigationCoordinator` is responsible for managing navigation throughout the app and providing common functionality, such as:

 - Navigating to a new screen
 - Navigating back to the previous screen
 - Presenting a sheet
 - Presenting a full-screen view

 Todo Qamar.k
 Additional functions will be added as required in the future to support enhanced navigation capabilities till now those are Enough for me.
 */

class NavigationCoordinator: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    @Published var presentedSheet: Sheet?
    @Published var presentedFullScreenCover: FullScreenRoute?
    
    // Singleton instance for global navigation
    static let shared = NavigationCoordinator()
    
    // Navigation state history for back/forward handling
    private var navigationHistory: [NavigationDestination] = []
    
    // MARK: - Navigation Methods
    func navigate(to destination: NavigationDestination) {
        navigationPath.append(destination)
        navigationHistory.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
        navigationHistory.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
        navigationHistory.removeAll()
    }
    
    func presentSheet(_ sheet: Sheet) {
        presentedSheet = sheet
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
    
    func presentFullScreen(_ route: FullScreenRoute) {
        presentedFullScreenCover = route
    }
    
    func dismissFullScreen() {
        presentedFullScreenCover = nil
    }
    
}
