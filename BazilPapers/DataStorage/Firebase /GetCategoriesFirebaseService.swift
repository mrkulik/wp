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
                moCategory.id = remoteCategory.id
                moCategory.title = remoteCategory.title
                return
            }
            storedCategory.id = remoteCategory.id
            storedCategory.title = remoteCategory.title
            storedCategories.removeAll(where: { (c) -> Bool in
                return c === storedCategory
            })
        }
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
