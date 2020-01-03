//
//  UIViewController+Child.swift
//  Internal
//
//  Created by wx on 7/26/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildContainer(_ viewController: UIViewController, containerSubview: UIView? = nil) {
        let containerView: UIView! = containerSubview ?? self.view
        
        self.addChild(viewController)
        containerView.addSubview(viewController.view)
        containerView.setRectConstraints(toSubview: viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeChildContainerFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func replaceChildContainer(_ oldVC: UIViewController, with newVC: UIViewController, in containerSubview: UIView? = nil,
                               duration: TimeInterval = 0.25, options: UIView.AnimationOptions = [.curveEaseInOut, .transitionFlipFromBottom]) {
        
        guard oldVC.parent === self, newVC.parent == nil else {
            return
        }
        
        let containerView: UIView! = containerSubview ?? self.view
        
        oldVC.willMove(toParent: nil)
        self.addChild(newVC)
        
        UIView.transition(with: containerView, duration: duration, options: options, animations: {
            oldVC.view.removeFromSuperview()
            containerView.addSubview(newVC.view)
            
            containerView.setRectConstraints(toSubview: newVC.view)
            containerView.layoutIfNeeded()
            
        }) { _ in
            oldVC.removeFromParent()
            newVC.didMove(toParent: self)
        }
    }
}
