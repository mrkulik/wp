//
//  String+Substring.swift
//  Internal
//
//  Created by wx on 4/4/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

extension String {
    var range: NSRange {
        return NSRange(location: 0, length: self.count)
    }
    
    func substring(range: NSRange) -> String {
        let s = self.prefix(range.upperBound).suffix(range.length)
        return String(s)
    }
    
    func appending(_ string: String, times: Int) -> String {
        var i = times
        var s = self
        
        while i > 0 {
            s = s.appending(string)
            i -= 1
        }
        
        return s
    }
}
