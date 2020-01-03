//
//  UIDevice+Formfactor.swift
//  sberservice
//
//  Created by Kulik Gleb on 7/26/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit


extension UIDevice {
    enum ScreenType: String {
        case iPhone4 = "iPhone 4 or iPhone 4S"
        case iPhone5 = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhone8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhone8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneXRorXSMax = "iPhone XR, iphone XSMax"
        case iPhoneX = "iPhone X, iPhoneXS"
        case unknown
    }
    
    
    var screenType: ScreenType {
        switch UIScreen.main.bounds.size.height {
        case 480:
            return .iPhone4
        case 568:
            return .iPhone5
        case 667:
            return .iPhone8
        case 736:
            return .iPhone8Plus
        case 812:
            return .iPhoneX
        case 896:
            return .iPhoneXRorXSMax
        default:
            return .unknown
        }
    }
}

