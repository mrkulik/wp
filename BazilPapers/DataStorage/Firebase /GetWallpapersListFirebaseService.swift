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
    
    private var moWallpapersInfo: [MOWallpaperInfo] {
        let request: NSFetchRequest<MOWallpaperInfo> = MOWallpaperInfo.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private func syncWithLocal(_ snapshot: [[String : Any]]) {
        
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
