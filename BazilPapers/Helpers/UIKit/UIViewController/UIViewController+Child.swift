//
//  UIViewController+Child.swift
//  BazilPapers
//
//  Created by Kulik on 1/7/20.
//  Copyright © 2020 Kulik. All rights reserved.
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


extension UIView {
    func setRectConstraints(toSubview subview: UIView, offset: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: self.topAnchor, constant: offset).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset).isActive = true
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
    }

    func asyncSetBackgroundColor(_ color: UIColor?) {    // to fix some strange bug
        self.backgroundColor = color
        DispatchQueue.main.async {
            self.backgroundColor = color
        }
    }
    
    func layoutIfNeededAnimated(with notification: Notification, alphaAnimatableSubview: UIView? = nil) {
        let duration = notification.keyboardAnimationDuration
        let options = UIView.AnimationOptions(curve: notification.keyboardAnimationCurve)
        
        var endAlpha: CGFloat = 1.0
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            endAlpha = 1.0
        }
        else if notification.name == UIResponder.keyboardWillHideNotification {
            endAlpha = 0.0
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            alphaAnimatableSubview?.alpha = endAlpha
            self.layoutIfNeeded()
        })
        
    }
    
    func setBackgroundColor(_ color: UIColor?) {
        self.backgroundColor = color
        self.layoutIfNeeded()
    }
}


extension Notification {
    var keyboardAnimationDuration: TimeInterval {
        let info = self.userInfo as? [String : Any]
        let d = info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        
        return d?.doubleValue ?? 0
    }

    var keyboardAnimationCurveOptions: UIView.AnimationOptions {
        let a = UIView.AnimationOptions(curve: self.keyboardAnimationCurve)
        return a
    }
    
    var keyboardAnimationCurve: UIView.AnimationCurve {
        let info = self.userInfo as? [String : Any]
        let i = info?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        
        guard let ii = i?.intValue, let curve = UIView.AnimationCurve(rawValue: ii) else {
            return UIView.AnimationCurve.linear
        }
        
        return curve
    }
    
    var keyboardAnimationEndFrame: CGRect {
        let info = self.userInfo as? [String : Any]
        let v = info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        
        return v?.cgRectValue ?? CGRect.zero
    }
    
    func keyboardAnimationEndFrame(inView view: UIView) -> CGRect {
        let r = view.convert(self.keyboardAnimationEndFrame, from: UIScreen.main.coordinateSpace)
        
        return r
    }
}


extension UIView.AnimationOptions {
    init(curve: UIView.AnimationCurve) {
        switch curve {
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .easeInOut:
            self = .curveEaseInOut
        case .linear:
            self = .curveLinear
        default:
            self = .curveLinear
        }
    }
}
