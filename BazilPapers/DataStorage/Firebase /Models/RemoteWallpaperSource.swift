//
//  RemoteWallpaperSource.swift
//  BazilPapers
//
//  Created by Kulik on 1/22/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


struct RemoteWallpaperSource {
    var formFactor: String?
    var storageType: String?
    var url: String?
    
    init(from dict: [String : Any]) {
        self.formFactor = dict["formFactorKey"] as? String
        self.storageType = dict["storageType"] as? String
        self.url = dict["uri"] as? String
    }
}
