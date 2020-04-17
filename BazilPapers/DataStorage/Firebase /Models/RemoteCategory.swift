//
//  RemoteCategory.swift
//  BazilPapers
//
//  Created by Kulik on 1/14/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


struct RemoteCategory {
    var id: Int32!
    var title: String?
    var iconURL: String?
    var order: Int32
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? Int32
        let i18n = dict["i18n"] as? [String : Any]
        let languageCode = Locale.current.languageCode ?? Constant.defaultLanguageCode
        if let title = i18n?[languageCode] as? String {
            self.title = title
        }
        let icon = dict["icon"] as? [String : Any]
        let iconURL = icon?["uri"] as? String
        self.iconURL = iconURL
        self.order = dict["order"] as? Int32 ?? .max
    }
}


private struct Constant {
    static let defaultLanguageCode = "en"
}
