//
//  UserDefaults+flags.swift
//  BazilPapers
//
//  Created by Kulik on 10/23/20.
//  Copyright © 2020 Kulik. All rights reserved.
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
    
    static func checkTrialCompleteAndSetIfNot() -> Bool {
        UserDefaults.checkAndSetIfNot(forKey: "isTrial")
    }
    
    static func checkSecondTrialCompleteAndSetIfNot() -> Bool {
        UserDefaults.checkAndSetIfNot(forKey: "isSecondTrial")
    }
}
