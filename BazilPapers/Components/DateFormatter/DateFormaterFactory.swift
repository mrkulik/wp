//
//  DateFormaterFactory.swift
//  DefaultUser
//
//  Created by alex borisoft on 22.11.2019.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

enum DateFormatterType {
    
    case extended
    case onlyMonth
    case onlyDay
    case orderConvinienceTime
    case custom(format: String)
    
    var dateFormat: String {
        switch self {
        case .extended:
            return "yyyy-MM-dd'T'HH:mm:ss"
        case .onlyMonth:
            return "MMMM"
        case .onlyDay:
            return "d"
        case .orderConvinienceTime:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .custom(let format):
            return format
        }
        
    }
}

struct DateFormatterFactory {

    static func makeFormatter(for type: DateFormatterType) -> DateFormatter {
        let dateFormatter = DateFormatter()
       
        dateFormatter.locale = LocaleFactory.makeLocale(for: .ruRu)
        dateFormatter.dateFormat = type.dateFormat
    
        return dateFormatter
    }
}
