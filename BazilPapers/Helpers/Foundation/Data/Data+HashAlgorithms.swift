//
//  Data+HashAlgorithms.swift
//  sberservice
//
//  Created by wx on 9/5/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    enum Algorithm {
        case sha256
        
        var digestLength: Int {
            switch self {
            case .sha256:
                return Int(CC_SHA256_DIGEST_LENGTH)
            }
        }
    }
    
    func hash(for algorithm: Algorithm) -> Data {
        let hashData = UnsafeMutablePointer<UInt8>.allocate(capacity: algorithm.digestLength)
        
        defer {
            hashData.deallocate()
        }
        
        switch algorithm {
        case .sha256:
            withUnsafeBytes { (buffer) -> Void in
                guard let dst = buffer.baseAddress else {
                    return
                }
                
                CC_SHA256(dst, CC_LONG(buffer.count), hashData)
            }
        }
        
        return Data(bytes: hashData, count: algorithm.digestLength)
    }
}
