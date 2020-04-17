//
//  GetPremiumCategoriesFirebaseService.swift
//  BazilPapers
//
//  Created by Kulik on 4/16/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import Firebase
import CoreData


class GetPremiumCategoriesFirebaseService {
    private let dbConfigsCatalogReference: DatabaseReference = Database.database(url: C.configsCatalogURL).reference()
    
    private var premiumPreviewPicturesReferencePath: DatabaseReference {
        return dbConfigsCatalogReference.child("catalog").child("premiumPreviewPictures")
    }
    
    private var moPictures: [MOPremiumPreviewPicture] {
        let request: NSFetchRequest<MOPremiumPreviewPicture> = MOPremiumPreviewPicture.fetchRequest()
        let result = try? self.catalogContext.fetch(request)
        return result ?? []
    }
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private func syncWithLocal(_ snapshot: [[String : Any]]) {
        self.catalogContext.delete(self.moPictures)
        snapshot.forEach { (p) in
            let moPicture = MOPremiumPreviewPicture(context: self.catalogContext)
            let source = p["source"] as? [String : Any]
            moPicture.url = source?["uri"] as? String
        }
        
        try? self.catalogContext.save()
    }

    func observeConfigsCatalogWithSingleEvent() {
        premiumPreviewPicturesReferencePath.observeSingleEvent(of: .value, with: { (snapshot) in
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
