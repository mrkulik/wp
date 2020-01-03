//
//  UIViewController+InstanceActionSheet.swift
//  sberservice
//
//  Created by User on 8/22/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    class func initialActionSheet() -> ActionSheetContainerViewController {
        let vc = ActionSheetContainerViewController.initial()
        vc.contentViewController = self.initial()
        
        return vc
    }
}
