//
//  LoginViewModel.swift
//  My First Swift
//
//  Created by Qamar khan on 1/14/25.
//

import Foundation

final class LoginViewModel: BaseViewModel {
    
    @Published var uiState: LoginUIState = .init()
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func validateInput() -> Bool {
        var isValid = true
        
        if uiState.userEmail.isEmpty {
            uiState.emailError = "Email is required"
            isValid = false
        } else if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: uiState.userEmail) {
            uiState.emailError = "Invalid email format"
            isValid = false
        } else {
            uiState.emailError = nil
        }
        
        if uiState.userPassword.isEmpty {
            uiState.passwordError = "Password is required"
            isValid = false
        } else if uiState.userPassword.count < 8 {
            uiState.passwordError = "Password must be at least 8 characters"
            isValid = false
        } else {
            uiState.passwordError = nil
        }
        
        return isValid
    }
    
    @MainActor
    func login() async {
        guard validateInput() else { return }
        
        uiState.isLoading = true
        do {
            // Simulate API call
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            coordinator.navigate(to: .dashboard)
        } catch {
            print("Login error: \(error)")
        }
        uiState.isLoading = false
    }
    
    func onClickGoogleLogin() {
        // Present a sheet
        // coordinator.presentSheet(.filter)
        coordinator.navigate(to: .dashboard)
    }
    
    func onClickFacebookLogin() {
        // coordinator.presentFullScreen(.onboarding)
        coordinator.presentSheet(.share(itemId: "User123"))
    }
}
