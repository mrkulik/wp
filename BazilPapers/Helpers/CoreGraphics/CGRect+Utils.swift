//
//  CGRect+Utils.swift
//  Internal
//
//  Created by wx on 31.05.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
    
    var top: CGFloat {
        return self.origin.y
    }

    var bottom: CGFloat {
        return self.origin.y + self.size.height
    }
    
    var leftShifted: CGRect {
        var r = self
        r.origin.x -= r.size.width
        return r
    }
    
    var rightShifted: CGRect {
        var r = self
        r.origin.x += r.size.width
        return r
    }
}

