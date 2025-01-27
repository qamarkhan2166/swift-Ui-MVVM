//
//  FavoriteButton.swift
//  My First Swift
//
//  Created by Qamar khan on 1/26/25.
//


import SwiftUI

struct FavoriteButton: View {
    let isFav: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isFav ? "heart.fill" : "heart")
                .foregroundColor(isFav ? .yellow : .white)
                .font(.title2)
        }
        .padding()
    }
}

// MARK: - Preview
struct FavoriteButtonPreview: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFav: true, action: {})
    }
}
