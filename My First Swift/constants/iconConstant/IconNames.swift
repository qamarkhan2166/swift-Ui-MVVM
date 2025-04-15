//
//  IconNames.swift
//  My First Swift
//
//  Created by Qamar khan on 1/29/25.
//

import SwiftUI

enum IconNames: String {
    case google = "google"
    case facebook = "facebook_icon"
    case globe = "globe"
    case checkMarkSquare = "checkmark.square"
    case checkMarkOnlySquare = "square"
    case filledStar = "star.fill"
    case nonFilledStar = "star"
    
    var value: String {
        return self.rawValue
    }
}

extension Image {
    static let example = Image("name of image")
}

