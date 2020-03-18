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
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? Int32
        let key = dict["key"] as? String
        let i18n = dict["i18n"] as? [String : Any]
        let languageCode = Locale.current.languageCode ?? Constant.defaultLanguageCode
        if let title = i18n?[languageCode] as? String {
            self.title = title
        }
        else {
            self.title = i18n?[Constant.defaultLanguageCode] as? String
        }
    }
}


private struct Constant {
    static let defaultLanguageCode = "en"
}
