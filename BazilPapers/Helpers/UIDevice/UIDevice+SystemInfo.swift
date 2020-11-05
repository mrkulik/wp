//
//  UIDevice+SystemInfo.swift
//  BazilPapers
//
//  Created by Kulik on 1/14/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()

}


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
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
