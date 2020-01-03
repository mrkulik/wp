//
//  Date+Make.swift
//  sberservice
//
//  Created by wx on 10/2/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension Date {
    static func make(fromUTC utcString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let date = formatter.date(from: utcString)
        
        return date
    }
}
