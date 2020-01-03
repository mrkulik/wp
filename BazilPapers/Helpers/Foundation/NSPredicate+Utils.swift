//
//  NSPredicate+Utils.swift
//  Internal
//
//  Created by wx on 20.09.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

extension NSPredicate {
    class func inputingPhone(phoneMask: String, digitPlaceholder: Character) -> NSPredicate {
        let regexParts = phoneMask.map { (c) -> String in
            let cc = c == digitPlaceholder ? "[0-9]" : String(c).regex
            return "(" + cc
        }
        
        let regex = regexParts.joined().appending(")?+", times: regexParts.count)
        let p = NSPredicate.matchString(toRegex: regex)
       
        return p
    }

    class func phone(phoneMask: String, digitPlaceholder: Character) -> NSPredicate {
        let regexParts = phoneMask.map { (c) -> String in
            let cc = c == digitPlaceholder ? "[0-9]" : String(c).regex
            return cc
        }
        
        let phoneNumberRegex = regexParts.joined()
        let p = NSPredicate.matchString(toRegex: phoneNumberRegex)
        
        return p
    }

    class func equalString(key: String, object: Any) -> NSPredicate {
        let p = NSPredicate(format: "\(key) == '\(object)'")
        return p
    }

    class func equalValue(key: String, object: Any) -> NSPredicate {
        let p = NSPredicate(format: "\(key) == %@", object as! NSObject)
        return p
    }
    
    class func containsc(key: String, text: String) -> NSPredicate {
        let p = NSPredicate(format: "\(key) contains[c] %@", text)
        return p
    }
    
    class func matchString(toRegex regex: String) -> NSPredicate {
        let p = NSPredicate(format: "SELF MATCHES %@", regex)
        return p
    }
    
    class func notNil(key: String) -> NSPredicate {
        let p = NSPredicate(format: "\(key) != nil")
        return p
    }
}
