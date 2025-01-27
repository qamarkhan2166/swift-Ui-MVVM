//
//  PrimaryButton.swift
//  My First Swift
//
//  Created by Qamar khan on 1/26/25.
//


import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isEnabled ? Color.blue : Color.gray.opacity(0.5))
                .foregroundColor(isEnabled ? Color.white : Color.gray)
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
    }
}

// MARK: - Preview
struct PrimaryButtonPreviews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(
            title: "Submit",
            isEnabled: true,
            action: {}
        )
    }
}
