//
//  Titlable.swift
//  sberservice
//
//  Created by wx on 10/9/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

public protocol Titlable {
    var title: String { get }
}

extension Titlable where Self: CaseIterable {
    static func caseForTitle(_ title: String) -> Self? {
        let c = Self.allCases.first { (c) -> Bool in
            return c.title == title
        }
        
        return c
    }
}

