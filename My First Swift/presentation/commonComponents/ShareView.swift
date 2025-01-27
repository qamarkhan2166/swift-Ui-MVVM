//
//  ShareView.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

import SwiftUI

struct ShareView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    init(itemId: String) {
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
            }
            .padding()
            .navigationTitle("Share")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(itemId: "123")
    }
}
