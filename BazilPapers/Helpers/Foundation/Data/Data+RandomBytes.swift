//
//  Data+RandomBytes.swift
//  sberservice
//
//  Created by wx on 9/5/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension Data {
    static var random96Bytes: Data {
        let data = self.random16Bytes(times: 6)
        return data
    }
    
    static var random32Bytes: Data {
        let data = self.random16Bytes(times: 2)
        return data
    }
    
    static func random16Bytes(times: Int = 1) -> Data {
        var data = Data()
        var i = times
        
        while i > 0 {
            data.append(self.random16Bytes)
            i -= 1
        }
        
        return data
    }
    
    static var random16Bytes: Data {
        let id = UUID()
        return id.bytesData
    }
}
