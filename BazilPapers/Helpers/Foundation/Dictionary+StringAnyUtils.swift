//
//  Dictionary+StringAnyUtils.swift
//  sberservice
//
//  Created by wx on 9/22/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func dictionaryForKey(_ key: String) -> [String: Any]? {
        return self[key] as? Dictionary<String, Any>
    }
    
    func arrayForKey(_ key: String) -> [Any]? {
        return self[key] as? Array<Any>
    }
}
