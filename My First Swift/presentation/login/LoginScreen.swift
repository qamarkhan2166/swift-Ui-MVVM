//
//  LoginScreen.swift
//  My First Swift
//
//  Created by Qamar khan on 1/11/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            headerSection()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    inputFieldsSection
                    optionsSection()
                    loginButtonSection()
                    socialMediaLoginSection(
                        actionGoogle: {
                            viewModel.onClickGoogleLogin()
                        },
                        actionFacebook: {
                            viewModel.onClickFacebookLogin()
                        }
                    )
                }
                .padding(.horizontal, 16)
            }
            
            footerSection()
                .padding(.horizontal, 16)
        }
        .overlay {
            if viewModel.uiState.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
            }
        }
    }
    
    private var inputFieldsSection: some View {
        VStack(spacing: 16) {
            CustomTextField(
                placeholder: "Email",
                text: $viewModel.uiState.userEmail,
                error: viewModel.uiState.emailError
            )
            
            CustomTextField(
                placeholder: "Password",
                text: $viewModel.uiState.userPassword,
                error: viewModel.uiState.passwordError,
                isSecure: true
                // showPassword: viewModel.uiState.showPassword
            )
        }
    }
    
    private func loginButtonSection() -> some View {
        PrimaryButton(
            title: "Login",
            isEnabled: viewModel.uiState.isLoginEnabled
        ) {
            Task {
                await viewModel.login()
            }
        }
    }
}

@ViewBuilder
private func headerSection() -> some View {
    HStack {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            VStack(
                alignment: .leading,
                spacing: 32
            ) {
                HStack {
                    Image(systemName: "globe")
                        .resizable().scaledToFit().frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text("Lorem ispum")
                        .font(.body).bold()
                        .foregroundColor(.white)
                    
                }
                Text("Sign in to your Account")
                    .font(.title2).bold()
                    .foregroundColor(.white)
            }.padding(.top, 32)
            
            HStack {
                Text("Don't have an account?").font(.caption).bold().foregroundStyle(.white)
                Text("Sign up").font(.caption).bold().foregroundColor(.blue).underline()
            }
        }
        Spacer()
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 24).background(Color.black)
}

@ViewBuilder
private func optionsSection() -> some View {
    HStack {
        Toggle(isOn: .constant(false)) {
            Text("Remember me")
        }
        .toggleStyle(CheckboxToggleStyle())
        Spacer()
        Text("Forgot Password?")
            .foregroundColor(.blue)
    }
    .font(.subheadline).padding(.top, 10)
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}

@ViewBuilder
private func socialMediaLoginSection(
    actionGoogle: @escaping () -> Void,
    actionFacebook: @escaping () -> Void
) -> some View {
    VStack(spacing: 12) {
        Text("Or login with")
        HStack(spacing: 16) {
            socialMediaButton(icon: "google", label: "Google", action: actionGoogle)
            socialMediaButton(icon: "facebook_icon", label: "Facebook", action: actionFacebook)
        }
    }.padding(.top, 20)
}

private func socialMediaButton(icon: String, label: String, action: @escaping () -> Void) -> some View {
    HStack {
        Image(icon)
        Text(label)
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .foregroundColor(.black)
    .cornerRadius(8)
    .overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
    )
    .onTapGesture {
        action()
    }
}

@ViewBuilder
private func footerSection() -> some View {
    VStack(spacing: 8) {
        Text("By signing up, you agree to the")
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.center)
            .font(.footnote)
        
        HStack(spacing: 4) {
            Text("Terms of Service")
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            Text("and")
                .foregroundColor(Color.gray)
            Text("Data Processing Agreement")
                .foregroundColor(Color.black)
                .fontWeight(.bold)
        }
        .multilineTextAlignment(.center)
        .font(.footnote)
    }
    .padding(.bottom, 20)
    .frame(maxWidth: .infinity, alignment: .center)
}

// MARK: - Preview
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
