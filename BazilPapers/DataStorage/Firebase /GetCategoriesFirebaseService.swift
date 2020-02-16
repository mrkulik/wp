//
//  GetFirebaseDataService.swift
//  BazilPapers
//
//  Created by Kulik on 1/10/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import Firebase
import CoreData


class GetCategoriesFirebaseService {
    private let dbConfigsCatalogReference: DatabaseReference = Database.database(url: Constant.configsCatalogURL).reference()
    
    private var categoriesReferencePath: DatabaseReference {
        return dbConfigsCatalogReference.child("catalog").child("categories")
    }
    
    private var moCategories: [MOCategory] {
        let request: NSFetchRequest<MOCategory> = MOCategory.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private func syncWithLocal(_ snapshot: [[String : Any]]) {
        var storedCategories = self.moCategories
        
        snapshot.forEach { (snapshotCategory) in
            let remoteCategory = RemoteCategory(from: snapshotCategory)

            guard let storedCategory = storedCategories.first(where: { (c) -> Bool in
                return c.id == remoteCategory.id
            }) else {
                let moCategory = MOCategory(context: self.catalogContext)
                fillData(local: moCategory, remote: remoteCategory)
                return
            }
            fillData(local: storedCategory, remote: remoteCategory)
            storedCategories.removeAll(where: { (c) -> Bool in
                return c === storedCategory
            })
        }
        self.catalogContext.delete(storedCategories)
        try? self.catalogContext.save()
    }
    
    private func fillData(local: MOCategory, remote: RemoteCategory) {
        local.id = remote.id
        local.title = remote.title
    }
    
    func observeConfigsCatalogtWithSingleEvent() {
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

private struct Constant {
    static let configsCatalogURL: String = "https://configs-catalog.firebaseio.com/"
}
