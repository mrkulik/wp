//
//  CGColor+Utils.swift
//  sberservice
//
//  Created by admin on 7/19/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

extension CGColor {
    var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
}
