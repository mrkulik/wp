//
//  String+Regex.swift
//  Internal
//
//  Created by wx on 4/4/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

extension String {
    func matchToRegex( _ regex: String) -> Bool {
        let p = NSPredicate.matchString(toRegex: regex)
        return p.evaluate(with: self)
    }
    
    func matches(regex: String) -> [String] {
        guard let r = try? NSRegularExpression(pattern: regex, options: .caseInsensitive) else {
            return []
        }
        
        let results = r.matches(in: self, options: .reportCompletion, range: self.range).map { (m) -> String in
            return self.substring(range: m.range)
        }
        
        return results
    }
    
    func removingMatches(regex: String) -> String {
        let s = self.replacingMatches(regex: regex, with: "")
        return s
    }
    
    func replacingMatches(regex: String, with string: String) -> String {
        var s = self
        
        if let r = try? NSRegularExpression(pattern: regex, options: .caseInsensitive) {
            s = r.stringByReplacingMatches(in: self, options: .reportCompletion, range: s.range, withTemplate: string)
        }
        
        return s
    }
    
    var generalTrimmingWhitespaces: String {
        var s = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let r = try? NSRegularExpression(pattern: " +", options: .caseInsensitive) {
            s = r.stringByReplacingMatches(in: s, options: .reportCompletion, range: s.range, withTemplate: " ")
        }
        
        return s
    }
    
    var regex: String {
        let parts = self.map { (c) -> String in
            var s = String(c)
            
            switch c {
            case "$", "+", "-", "*", "/", "(", ")":
                s = "\\" + s
                
            default:
                //nothing
                break
            }
            
            return s
        }
        
        return parts.joined()
    }
}
