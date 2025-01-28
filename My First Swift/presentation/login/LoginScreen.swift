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
                placeholder: AuthStrings.emailPlaceholder.localizedKey,
                text: $viewModel.uiState.userEmail,
                error: viewModel.uiState.emailError
            )
            
            CustomTextField(
                placeholder: AuthStrings.passwordPlaceholder.localizedKey,
                text: $viewModel.uiState.userPassword,
                error: viewModel.uiState.passwordError,
                isSecure: true
            )
        }
    }
    
    private func loginButtonSection() -> some View {
        PrimaryButton(
            title: AuthStrings.loginBtnText.localizedKey,
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
                    Image(systemName: IconNames.globe.value)
                        .resizable().scaledToFit().frame(width: 20, height: 20)
                        .foregroundColor(.white)
                    Text(AuthStrings.loremIpsum.localizedKey)
                        .font(.body).bold()
                        .foregroundColor(.white)
                    
                }
                Text(AuthStrings.signInTitle.localizedKey)
                    .font(.title2).bold()
                    .foregroundColor(.white)
            }.padding(.top, 32)
            
            HStack {
                Text(AuthStrings.noAccount.localizedKey).font(.caption).bold().foregroundStyle(.white)
                Text(AuthStrings.signUp.localizedKey).font(.caption).bold().foregroundColor(.blue).underline()
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
            Text(AuthStrings.rememberMe.localizedKey)
        }
        .toggleStyle(CheckboxToggleStyle())
        Spacer()
        Text(AuthStrings.forgotPassword.localizedKey)
            .foregroundColor(.blue)
    }
    .font(.subheadline).padding(.top, 10)
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? IconNames.checkMarkSquare.value : IconNames.checkMarkOnlySquare.value)
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
        Text(AuthStrings.orLoginWith.localizedKey)
        HStack(spacing: 16) {
            socialMediaButton(icon: IconNames.google.value, label: AuthStrings.google.localizedKey, action: actionGoogle)
            socialMediaButton(icon: IconNames.facebook.value, label: AuthStrings.facebook.localizedKey, action: actionFacebook)
        }
    }.padding(.top, 20)
}

private func socialMediaButton(icon: String, label: LocalizedStringKey, action: @escaping () -> Void) -> some View {
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
        Text(AuthStrings.agreeToTerms.localizedKey)
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.center)
            .font(.footnote)
        
        HStack(spacing: 4) {
            Text(AuthStrings.termsOfService.localizedKey)
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            Text(AuthStrings.andText.localizedKey)
                .foregroundColor(Color.gray)
            Text(AuthStrings.dataProcessingAgreement.localizedKey)
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
