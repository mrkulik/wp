//
//  KeyboardBottomOffsetController.swift
//  Internal
//
//  Created by wx on 14.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

protocol KeyboardBottomOffsetControllerDelegate: class {
    func controllerDidLayoutOffset(_ controller: KeyboardBottomOffsetController)
}

class KeyboardBottomOffsetController: NSObject {
    weak var delegate: KeyboardBottomOffsetControllerDelegate?
    
    weak var superView: UIView!
    weak var subview: UIView?

    weak var bottomOffset: NSLayoutConstraint! {
        didSet {
            if self.bottomOffset != nil {
                self.initialBottomOffset = self.bottomOffset.constant
            }
        }
    }

    var subviewBottomOffset: CGFloat = 12

    private var initialBottomOffset: CGFloat = 0
    
    override init() {
        super.init()
        
        let show = UIResponder.keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_ :)), name: show, object: nil)

        let hide = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_ :)), name: hide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

fileprivate extension KeyboardBottomOffsetController {
    @objc func willShowKeyboard(_ notification: Notification) {
        guard self.superView != nil, self.bottomOffset != nil else {
            return
        }
        
        let offset = self.getOffset(notification)

        self.setBottomOffset(notification, offset: offset)
    }
    
    @objc func willHideKeyboard(_ notification: Notification) {
        guard self.superView != nil, self.bottomOffset != nil else {
            return
        }

        self.setBottomOffset(notification, offset: self.initialBottomOffset)
    }
    
    func setBottomOffset(_ notification: Notification, offset: CGFloat) {
        let duration = notification.keyboardAnimationDuration
        let options = notification.keyboardAnimationCurveOptions

        self.bottomOffset?.constant = offset
        
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            self?.superView.layoutIfNeeded()
            
        }) { [weak self] _ in
            if let strongSelf = self {
                strongSelf.delegate?.controllerDidLayoutOffset(strongSelf)
            }
        }
    }
    
    func getOffset(_ notification: Notification) -> CGFloat {
        let frame = notification.keyboardAnimationEndFrame
        let keyboardFrame = self.superView.convert(frame, from: UIScreen.main.coordinateSpace)

        let offset: CGFloat!
        
        if let subview = self.subview {
            let bounds = self.superView.convert(subview.bounds, from: subview)
            offset = bounds.bottom + self.subviewBottomOffset - keyboardFrame.origin.y
        }
        else {
            offset = self.superView.bounds.bottom - keyboardFrame.origin.y
        }

        return offset
    }
}
