//
//  UIView+ActionSheetLayerStyle.swift
//  sberservice
//
//  Created by User on 9/6/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    var actionSheetCornerRadiusStandardValue: CGFloat {
        return 12
    }
    
    func setupActionSheetLayerStyle(cornerRadius: CGFloat? = nil) {
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = cornerRadius ?? self.actionSheetCornerRadiusStandardValue
        self.clipsToBounds = true
    }
}
