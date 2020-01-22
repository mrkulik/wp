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
    private let dbConfigsCatalogReference: DatabaseReference = Database.database(url: Constant.configsCatalogURL).reference()
    
    private var categoriesReferencePath: DatabaseReference {
        return dbConfigsCatalogReference.child("catalog").child("pictures")
    }
    
    private var moWallpapers: [MOWallpaper] {
        let request: NSFetchRequest<MOWallpaper> = MOWallpaper.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private func syncWithLocal(_ snapshot: [[String : Any]]) {
        var storedCategories = self.moWallpapers
        
//        snapshot.forEach { [weak self] (snapshotCategory) in
//            let remoteWallpaper = RemoteCategory(from: snapshotCategory)
//
//            guard let storedCategory = storedCategories.first(where: { (c) -> Bool in
//                return c.id == remoteCategory.id
//            }) else {
//                let moCategory = MOCategory.makeInContext(of: self?.moCatalog)
//                moCategory?.id = remoteCategory.id
//                moCategory?.key = remoteCategory.title
//                return
//            }
//            storedCategory.id = remoteCategory.id
//            storedCategory.key = remoteCategory.title
//            storedCategories.removeAll(where: { (c) -> Bool in
//                return c === storedCategory
//            })
//        }
        self.catalogContext.delete(storedCategories)
        try? self.catalogContext.save()
    }
    
    
    func observeConfigsCatalogtWithSingleEvent() {
        categoriesReferencePath.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let snapshot = snapshot.value as? [[String : Any]] else {
                return
            }
            
            self?.syncWithLocal(snapshot)
            })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
}

private struct Constant {
    static let configsCatalogURL: String = "https://configs-catalog.firebaseio.com/"
}
