//
//  RemoteWallpaper.swift
//  BazilPapers
//
//  Created by Kulik on 1/22/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


struct RemoteWallpaper {
    var id: Int32!
    var categoryIDs: [Int32]?
    var sources: [RemoteWallpaperSource]?
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? Int32
        self.categoryIDs = dict["categoryIds"] as? [Int32]
        let sources = dict["sources"] as? [[String : Any]]
        sources?.forEach({ (source) in
            self.sources?.append(RemoteWallpaperSource(from: source))
        })
    }
}
