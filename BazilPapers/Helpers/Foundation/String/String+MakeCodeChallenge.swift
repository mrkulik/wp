//
//  String+MakeCodeChallenge.swift
//  sberservice
//
//  Created by User on 9/7/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension String {
    func makeCodeChallenge(with hashAlgorithm: Data.Algorithm) -> String {
        guard let ascii = self.data(using: .ascii) else {
            return ""
        }
        
        let sha256 = ascii.hash(for: hashAlgorithm)
        let challenge = sha256.base64EncodedString()
        
        return challenge
    }
}
