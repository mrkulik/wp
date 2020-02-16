//
//  NSPredicate+Utils.swift
//  BazilPapers
//
//  Created by Kulik on 2/16/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation

extension NSPredicate {
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
    
    class func matchString(toMask mask: String) -> NSPredicate {
        let p = NSPredicate(format: "SELF MATCHES %@", mask)
        return p
    }
    
    class func notNil(key: String) -> NSPredicate {
        let p = NSPredicate(format: "\(key) != nil")
        return p
    }
}
