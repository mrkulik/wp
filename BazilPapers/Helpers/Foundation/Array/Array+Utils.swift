//
//  Array+Utils.swift
//  Internal
//
//  Created by wx on 11.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeLastIfExist() {
        guard !self.isEmpty else {
            return
        }
        
        self.removeLast()
    }
    
    mutating func removeFirstIfExist() -> Element? {
        guard !self.isEmpty else {
            return nil
        }

        return self.removeFirst()
    }
}
