//
//  UIViewController+KeyboardScroll.swift
//  sberservice
//
//  Created by User on 8/5/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    static func initialInKeyboardScroll() -> KeyboardScrollViewController {
        let vc = KeyboardScrollViewController.initial()
        vc.contentViewController = self.initial()
        
        return vc
    }
}
