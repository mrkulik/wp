//
//  UIView+Utils.swift
//  Internal
//
//  Created by wx on 26.05.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

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
