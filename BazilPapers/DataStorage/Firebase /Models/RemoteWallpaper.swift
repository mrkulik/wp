//
//  RemoteWallpaper.swift
//  BazilPapers
//
//  Created by Kulik on 1/22/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


struct RemoteWallpaperInfo {
    var id: Int32!
    var categoryID: Int32?
    var source: RemoteWallpaperSource?
    var shortSource: RemoteWallpaperSource?
    var order: Int32
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? Int32
        self.categoryID = dict["categoryId"] as? Int32
        let sources = dict["sources"] as? [[String : Any]]
        
        let shortSource = sources?.first(where: { (source) -> Bool in
            guard let picFormFactor = source["formFactorKey"] as? String else {
                return false
            }
            
            return picFormFactor == "640x960"
        })
        
        self.shortSource = RemoteWallpaperSource(from: shortSource)
        self.order = dict["order"] as? Int32 ?? .max
        
        guard let deviceFormFactor = UserDefaults.standard.object(forKey: "formFactor") as? String else {
            return
        }
        
        let fullSource = sources?.first(where: { (source) -> Bool in
            guard let picFormFactor = source["formFactorKey"] as? String else {
                return false
            }
            
            return picFormFactor == deviceFormFactor
        })
        
        self.source = RemoteWallpaperSource(from: fullSource)
    }
}
