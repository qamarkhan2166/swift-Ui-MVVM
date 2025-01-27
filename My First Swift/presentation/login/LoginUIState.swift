//
//  LoginUIState.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

struct LoginUIState {
    var userEmail: String = ""
    var userPassword: String = ""
    var emailError: String? = nil
    var passwordError: String? = nil
    var isLoading: Bool = false
    var showPassword: Bool = false
    
    var isLoginEnabled: Bool {
        !userEmail.isEmpty && !userPassword.isEmpty
    }
    
}
