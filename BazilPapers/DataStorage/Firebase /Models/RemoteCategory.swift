//
//  RemoteCategory.swift
//  BazilPapers
//
//  Created by Kulik on 1/14/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


struct RemoteCategory {
    var id: Int32!
    var title: String?
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? Int32
        self.title = dict["key"] as? String
    }
}
