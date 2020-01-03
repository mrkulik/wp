//
//  NSOrderedSet+Utils.swift
//  Internal
//
//  Created by wx on 17.10.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

extension NSOrderedSet {
    var secondObject: Any? {
        guard self.count > 1 else {
            return nil
        }
        
        return self.object(at: 1)
    }
    
    var thirdObject: Any? {
        guard self.count > 2 else {
            return nil
        }

        return self.object(at: 2)
    }
    
    var isEmpty: Bool {
        return self.count == 0
    }

    var isNotEmpty: Bool {
        return self.count != 0
    }
}
