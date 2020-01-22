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
