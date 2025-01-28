//
//  StringResourceKeys.swift
//  My First Swift
//
//  Created by Qamar khan on 1/28/25.
//

import SwiftUI

enum LocalizableStrings: String {
    case emailPlaceholder = "email_placeholder"
    case passwordPlaceholder = "password_placeholder"
    
    var localizedKey: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}

protocol LocalizableEnum: RawRepresentable where RawValue == String {
    var localizedKey: LocalizedStringKey { get }
}

extension LocalizableEnum {
    var localizedKey: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
}

enum AuthStrings: String, LocalizableEnum {
    case emailPlaceholder = "email_placeholder"
    case passwordPlaceholder = "password_placeholder"
}
