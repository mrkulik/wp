//
//  UIApplicationChainController.swift
//  sberservice
//
//  Created by User on 8/27/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

class UIApplicationChainController: NSObject, UIApplicationDelegate {
    var nextController: UIApplicationDelegate?
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let should = self.nextController?.application?(app, open: url, options: options) ?? false
        return should
    }
}
