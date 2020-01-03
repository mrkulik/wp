//
//  UUID+Bytes.swift
//  sberservice
//
//  Created by wx on 9/5/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension UUID {
    var bytesData: Data {
        let data = withUnsafeBytes(of: self.uuid) {
            Data($0)
        }
        
        return data
    }
}
