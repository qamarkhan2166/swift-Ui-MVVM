//
//  ComingSoon.swift
//  My First Swift
//
//  Created by Qamar khan on 1/29/25.
//


enum ComingSoon: String, LocalizableEnum {
    case comingSoon = "coming_soon"
    case knowMoreTapped = "know_more_tapped"
    case knowMore = "know_more"
}

enum GeneralError: String, LocalizableEnum {
    case errorMessage = "error_message"
    case tryAgain = "try_again"
}

enum CommonStrings: String, LocalizableEnum {
    case share = "share"
    case cancel = "cancel"
}
