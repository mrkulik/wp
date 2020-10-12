//
//  PulseButton.swift
//  BazilPapers
//
//  Created by Kulik on 10/12/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func setupPulseAnimation(toValue: Double?) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.9
        pulse.fromValue = 1.0
        pulse.toValue = toValue
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.2
        pulse.damping = 0.8

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4.0
        animationGroup.repeatCount = 3
        animationGroup.animations = [pulse]

        self.layer.add(animationGroup, forKey: "pulse")
    }
}
