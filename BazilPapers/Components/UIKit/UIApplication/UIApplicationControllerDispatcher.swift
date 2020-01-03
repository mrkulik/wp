//
//  UIApplicationControllerDispatcher.swift
//  sberservice
//
//  Created by User on 8/27/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

class UIApplicationControllerDispatcher: UIApplicationChainController {
    var controllers: [UIApplicationDelegate] = []
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var should = false
        
        for d in self.controllers {
            should = d.application?(app, open: url, options: options) ?? false
            
            if should {
                break
            }
        }
        
        if !should {
            should = super.application(app, open: url, options: options)
        }
        
        return should
    }
}
