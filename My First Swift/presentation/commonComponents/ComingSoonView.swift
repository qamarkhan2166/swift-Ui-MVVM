//
//  SampleContentView.swift
//  My First Swift
//
//  Created by Qamar khan on 1/18/25.
//

import Foundation

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        ZStack {
            // Background Color
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                
                // "COMING SOON" Text
                Text(ComingSoon.comingSoon.localizedKey)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.blue)
                
                // "Know more" Button
                Button(action: {
                    print(ComingSoon.knowMoreTapped.localizedString)
                }) {
                    Text(ComingSoon.knowMore.localizedKey)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 40)
                        .background(Color.gray)
                        .cornerRadius(20)
                }
                
                Spacer()
                
                // Dots Indicator
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                    
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                    
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

// MARK: - Preview
struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}
