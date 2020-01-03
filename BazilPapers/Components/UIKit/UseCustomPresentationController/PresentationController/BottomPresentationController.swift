//
//  BottomPresentationController.swift
//  Internal
//
//  Created by wx on 7/11/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit
import Foundation

@objc protocol BottomPresentable: class {
    var actionSheetHeight: CGFloat { get }
    
    @objc optional func performDissmissing()
}

class BottomPresentationController: UIPresentationController {
    var actionSheetHeight: CGFloat? {
        return self.presentableViewController?.actionSheetHeight
    }
    
    var presentableViewController: (UIViewController&BottomPresentable)? {
        return self.presentedViewController as? UIViewController&BottomPresentable
    }

    var containerSubview: UIView? {
        willSet {
            let gestureRecognizers = self.containerSubview?.gestureRecognizers ?? []
            for gr in gestureRecognizers {
                self.containerSubview?.removeGestureRecognizer(gr)
            }
        }
        didSet {
            guard let v = self.containerSubview else {
                return
            }
            
            let action = #selector(self.makeDissmissBottomPresentedViewController)
            
            let tap = UITapGestureRecognizer(target: self, action: action)
            let swipe = UISwipeGestureRecognizer(target: self, action: action)
            swipe.direction = [.down]
            
            v.addGestureRecognizer(tap)
            v.addGestureRecognizer(swipe)
        }
    }
    
    // MARK: - Life Cycle
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let v = self.containerView else {
            return .zero
        }
        
        var bounds = v.bounds

        if let h = self.actionSheetHeight {
            let safeHeight = h + v.safeAreaInsets.bottom
            
            bounds.origin.y += bounds.size.height - safeHeight
            bounds.size.height = safeHeight
        }
        
        return bounds
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = self.containerView, let subview = self.containerSubview else {
            return
        }
        
        subview.frame = containerView.bounds
        containerView.insertSubview(subview, at: 0)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.containerSubview?.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.containerSubview?.removeFromSuperview()
        }
    }
    
    // MARK: - Dynamic Actions
    @objc private func makeDissmissBottomPresentedViewController() {
        let action = #selector(BottomPresentable.performDissmissing)
        
        if self.presentableViewController?.responds(to: action) ?? false {
            self.presentableViewController?.performDissmissing?()
        }
        else {
            self.presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
