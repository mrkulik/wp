//
//  UINavigationController+PushWithNavigationBar.swift
//  sberservice
//
//  Created by wx on 8/13/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func pushWithBackButton(_ viewController: UIViewController, backImage: UIImage?, animated: Bool = true) {
        viewController.navigationItem.hidesBackButton = true
        
        viewController.navigationItem.leftBarButtonItem = ClosuredBarButtonItem(image: backImage, actionClosure: {
            self.popViewController(animated: animated)
        })
        
        self.pushViewController(viewController, animated: animated)
    }
    
    func pushWithBackButtonHiddingNavigationBar(_ viewController: UIViewController, backImage: UIImage?, animated: Bool = true) {
        viewController.navigationItem.hidesBackButton = true
        
        viewController.navigationItem.leftBarButtonItem = ClosuredBarButtonItem(image: backImage, actionClosure: {
            self.popAndHideNavigationBar(animated: animated)
        })
        
        self.pushAndShowNavigationBar(viewController, animated: animated)
    }
    
    func pushAndShowNavigationBar(_ viewController: UIViewController, animated: Bool = true) {
        CATransaction.begin()
        self.setNavigationBarHidden(false, animated: animated)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popAndHideNavigationBar(animated: Bool = true) {
        CATransaction.begin()
        self.setNavigationBarHidden(true, animated: animated)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }

    func popToRootAndHideNavigationBar(animated: Bool = true) {
        CATransaction.begin()
        self.setNavigationBarHidden(true, animated: animated)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
    func dissmissAndPopToRootViewController(animated: Bool = true, hideNavigationBar: Bool = true) {
        CATransaction.begin()
        self.dismiss(animated: animated, completion: nil)
        self.setNavigationBarHidden(hideNavigationBar, animated: animated)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

