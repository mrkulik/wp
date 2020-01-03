//
//  NSError+DataMapper.swift
//  sberservice
//
//  Created by User on 10/9/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension NSError {
    static func deserialize(object: Any? = nil, message: String = "I can't:(", code: Int = 8888, userInfo: [String : Any]? = nil) -> NSError {
        var d = "Deserializing"
        if let o = object {
            d += " \(type(of: o))"
        }
        d += ": \(message)"
        
        let e = NSError(domain: d, code: code, userInfo: userInfo)
        return e
    }
}

