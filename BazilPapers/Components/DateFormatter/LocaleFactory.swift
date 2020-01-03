//
//  LocaleFactory.swift
//  DefaultUser
//
//  Created by alex borisoft on 22.11.2019.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

enum LocaleType: String {
    
    case ruRu = "ru_RU"
}

struct LocaleFactory {
    
    static func makeLocale(for type: LocaleType) -> Locale {
        return .init(identifier: type.rawValue)
    }
}
