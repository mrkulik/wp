//
//  GetWallpapersListFirebaseService.swift
//  BazilPapers
//
//  Created by Kulik on 1/14/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import Firebase
import CoreData


class GetWallpapersListFirebaseService {
    private let dbConfigsCatalogReference: DatabaseReference = Database.database(url: C.configsCatalogURL).reference()
    
    private var categoriesReferencePath: DatabaseReference {
        return dbConfigsCatalogReference.child("catalog").child("pictures")
    }
    
    private var moWallpapersInfo: [MOWallpaperInfo] {
        let request: NSFetchRequest<MOWallpaperInfo> = MOWallpaperInfo.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private var moCategories: [MOCategory] {
        let request: NSFetchRequest<MOCategory> = MOCategory.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private func syncWithLocal(_ snapshot: [[String : Any]]) {
        var storedWallpaperInfos = self.moWallpapersInfo
        
        snapshot.forEach { (snapshotPicture) in
            let remoteWallpaperInfo = RemoteWallpaperInfo(from: snapshotPicture)

            guard let storedWallpaperInfo = moWallpapersInfo.first(where: { (wi) -> Bool in
                return wi.id == remoteWallpaperInfo.id
            }) else {
                let moWallpaperInfo = MOWallpaperInfo(context: self.catalogContext)
                fillData(local: moWallpaperInfo, remote: remoteWallpaperInfo)
                return
            }
            fillData(local: storedWallpaperInfo, remote: remoteWallpaperInfo)
            storedWallpaperInfos.removeAll(where: { (wi) -> Bool in
                return wi === storedWallpaperInfo
            })
        }
        self.catalogContext.delete(storedWallpaperInfos)
        try? self.catalogContext.save()
    }
    
    private func fillData(local: MOWallpaperInfo, remote: RemoteWallpaperInfo) {
        local.id = remote.id
        local.sourceURL = remote.source?.url
        local.shortSourceURL = remote.shortSource?.url
        local.category = moCategories.filter { (category) -> Bool in
            return category.id == remote.categoryID
        }.first
    }
    
    func observeConfigsCatalogWithSingleEvent() {
        categoriesReferencePath.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [[String : Any]] else {
                return
            }
            
            self.syncWithLocal(snapshot)
            })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
}
