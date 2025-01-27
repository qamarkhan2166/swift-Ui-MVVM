//
//  NavigationDestination.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.

// MARK: - Current Focus: Implementing Main Navigation
// Future Plans: Child and sub-child navigations, along with sheet presentations, will be added later.

enum NavigationDestination: Hashable {
    // Main Flow
    case login
    case dashboard
    /*
     Mark:- todo Qamar.k later
     Mark:- Dashboard Sub-flows
     
     case profile(userId: String)
     case settings
     case details(itemId: String)
     
     Mark:- Nested Flows
     
     case nestedFlow(NestedNavigationType)
     
     var title: String {
     switch self {
     case .login: return "Login"
     case .dashboard: return "Dashboard"
     case .profile: return "Profile"
     case .settings: return "Settings"
     case .details: return "Details"
     case .nestedFlow(let type): return type.title
     }
     }
     */
}

// MARK: - Todo Qamar.k i will implement all those step by step later on

enum NestedNavigationType: Hashable {
    case subItem(id: String)
    case categoryList
    case itemDetail(itemId: String)
    
    var title: String {
        switch self {
        case .subItem: return "Sub Item"
        case .categoryList: return "Categories"
        case .itemDetail: return "Item Detail"
        }
    }
}

enum Sheet: Identifiable {
    case filter
    case share(itemId: String)
    case settings
    
    var id: String {
        switch self {
        case .filter: return "filter"
        case .share(let itemId): return "share_\(itemId)"
        case .settings: return "settings"
        }
    }
}

enum FullScreenRoute: Identifiable {
    case onboarding
    case camera
    
    var id: String {
        switch self {
        case .onboarding: return "onboarding"
        case .camera: return "camera"
        }
    }
}
