//
//  Array+String.swift
//  Internal
//
//  Created by wx on 2/3/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

extension Array where Element == String {
    
    var longest: String? {
        return map { (long: $0.count, string: $0) }
            .max { $0.long < $1.long }
            .map { $0.string }
    }
}

