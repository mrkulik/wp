//
//  String+Random.swift
//  sberservice
//
//  Created by wx on 10/15/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension String {
    static func randomString(lenght: Int = 6) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomLetters = (0..<lenght).compactMap { _ in letters.randomElement() }
        
        return String(randomLetters)
    }
}
