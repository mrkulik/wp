//
//  Notification+UIKeyboard.swift
//  Internal
//
//  Created by wx on 3/7/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation
import UIKit

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
