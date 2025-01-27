//
//  CustomTextField.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    let text: Binding<String>
    let error: String?
    let isSecure: Bool
    @Binding var showPassword: Bool
    
    init(
        placeholder: String,
        text: Binding<String>,
        error: String? = nil,
        isSecure: Bool = false,
        showPassword: Binding<Bool> = .constant(false)
    ) {
        self.placeholder = placeholder
        self.text = text
        self.error = error
        self.isSecure = isSecure
        self._showPassword = showPassword
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if isSecure && !showPassword {
                    SecureField(placeholder, text: text)
                } else {
                    TextField(placeholder, text: text)
                }
                
                if isSecure {
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(error != nil ? Color.red : Color.gray.opacity(0.5), lineWidth: 1)
            )
            
            if let error = error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

// MARK: - Preview
struct CustomTextFieldPreviews: PreviewProvider {
    static var previews: some View {
        @State var textFieldInput = "Input Text"
        CustomTextField(
            placeholder: "Email",
            text: $textFieldInput
        )
    }
}
