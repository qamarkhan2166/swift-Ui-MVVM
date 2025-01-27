//
//  ContentView.swift
//  My First Swift
//
//  Created by Qamar khan on 12/17/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = NavigationCoordinator.shared
    
    var body: some View {
        
        NavigationStack(path: $coordinator.navigationPath) {
            LoginScreen()
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .login:
                        LoginScreen()
                    case .dashboard:
                        DashboardScreen()
                    }
                }
                .sheet(item: $coordinator.presentedSheet) { sheet in
                    switch sheet {
                    case .filter:
                        ComingSoonView()
                    case .share(let itemId):
                        ShareView(itemId: itemId)
                    case .settings:
                        ComingSoonView()
                    }
                }
                .fullScreenCover(item: $coordinator.presentedFullScreenCover) { route in
                    switch route {
                    case .onboarding:
                        ComingSoonView()
                    case .camera:
                        ComingSoonView()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
