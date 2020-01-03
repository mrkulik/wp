//
//  DimmingBottomPresentationController.swift
//  sberservice
//
//  Created by wx on 9/30/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

class DimmingBottomPresentationController: BottomPresentationController {
    weak var dimmingView: UIView! {
        get {
            return self.containerSubview
        }
        set {
            self.containerSubview = newValue
        }
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        self.showDimmingView(needsShow: true)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        self.showDimmingView(needsShow: false)
    }
    
    // MARK: - Helpers
    private func showDimmingView(needsShow: Bool) {
        let newAlpha: CGFloat = needsShow ? 1 : 0
        let oldAlpha: CGFloat = needsShow ? 0 : 1
        
        self.dimmingView.alpha = oldAlpha
        
        if let coordinator = self.presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = newAlpha
                
            }, completion: nil)
        }
        else {
            self.dimmingView.alpha = newAlpha
        }
    }
}
