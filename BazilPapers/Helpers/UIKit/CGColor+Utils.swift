//
//  CGColor+Utils.swift
//  Internal
//
//  Created by wx on 7/19/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation
import UIKit

extension CGColor {
    var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
}
