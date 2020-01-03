//
//  UIViewAnimationOptions+Utils.swift
//  Internal
//
//  Created by wx on 14.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

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
