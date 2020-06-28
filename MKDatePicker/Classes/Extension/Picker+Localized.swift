//
//  Picker+Localized.swift
//  XBDatePicker
//
//  Created by xiaobin liu on 2020/3/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Foundation


/// MARK - String + Localized
public extension String {
    
    func localized(value: String? = nil, table: String = "Language") -> String {
        guard let path = Bundle.module.path(forResource: Language.current.rawValue, ofType: "lproj") else {
            return self
        }
        return Bundle(path: path)?.localizedString(forKey: self, value: value, table: table) ?? self
    }
}


/// MARK - Language
public enum Language: String {
    case en = "en"
    case zhHans = "zh-Hans"
    
    static var current: Language {
        
        guard let language = NSLocale.preferredLanguages.first else { return .en }
        if language.contains(Language.zhHans.rawValue) { return .zhHans }
        
        return .en
    }
}

/// MARK - Bundle
private extension Bundle {
    
    static let module: Bundle = {
        
        let frameworkBundle = Bundle(for: PickerViewController.self)
        
        guard let path = frameworkBundle.path(forResource: "Langs", ofType: "bundle"),
            let bundle = Bundle(path: path) else
        {
            Swift.fatalError("SDK resource bundle cannot be found, please verify your installation is not corrupted and try to reinstall XBDatePickerSDK", file: #file, line: #line)
        }
        return bundle
    }()
}
