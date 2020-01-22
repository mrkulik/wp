//
//  DataStorageProvider.swift
//  BazilPapers
//
//  Created by Kulik on 1/11/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import CoreData

class DataStorageProvider {
    static let sharedCatalogModelController = PersistentContainerController(modelName: "Catalog")
    
    class func loadSharedStores() {
        self.sharedCatalogModelController.loadStores()
    }
}
