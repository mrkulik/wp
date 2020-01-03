//
//  String+Info.swift
//  Internal
//
//  Created by wx on 15/10/18.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

extension String {
    var hasNoZeroPrefix: Bool {
        guard self.count > 1 else {
            return true
        }
        
        return !self.hasPrefix("0")
    }
}
