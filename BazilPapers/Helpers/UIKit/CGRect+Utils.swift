//
//  CGRect+Utils.swift
//  BazilPapers
//
//  Created by Kulik on 6/12/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

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

