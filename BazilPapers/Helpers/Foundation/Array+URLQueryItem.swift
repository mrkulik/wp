//
//  Array+URLQueryItem.swift
//  sberservice
//
//  Created by User on 10/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    mutating func append(name: String, value: String) {
        let i = URLQueryItem(name: name, value: value)
        self.append(i)
    }
}
