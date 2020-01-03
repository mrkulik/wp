//
//  UserDefaults+Utils.swift
//  sberservice
//
//  Created by admin on 8/1/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func checkAndSetIfNot(forKey key: String) -> Bool {
        
        let defaults = UserDefaults.standard
        
        let isFalse = !defaults.bool(forKey: key)
        
        if isFalse {
            defaults.set(true, forKey: key)
        }
        
        return isFalse
    }
}
