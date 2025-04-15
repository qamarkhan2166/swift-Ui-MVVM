//
//  StringResourceKeys.swift
//  My First Swift
//
//  Created by Qamar khan on 1/28/25.
//

import SwiftUI

protocol LocalizableEnum: RawRepresentable where RawValue == String {
    var localizedKey: LocalizedStringKey { get }
    var localizedString: String { get }
}

extension LocalizableEnum {
    var localizedKey: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
