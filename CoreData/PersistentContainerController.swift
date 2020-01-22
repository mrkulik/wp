//
//  PersistentContainerController.swift
//  BazilPapers
//
//  Created by Kulik on 1/11/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import CoreData

protocol PersistentContainerControllerDelegate: class {
    func controller(_ controller: PersistentContainerController, didLoadSuccessful description: NSPersistentStoreDescription)
}

class PersistentContainerController {
    weak var delegate: PersistentContainerControllerDelegate?
    
    private (set) var container: NSPersistentContainer!
    
    var hasLoadedStores: Bool {
        return self.numberOfLoadingStores == 0
    }
    
    var isLoadingStores: Bool {
        return self.numberOfLoadingStores > 0
    }
    
    private let isNotStartedLoading: Int = -1
    private var numberOfLoadingStores: Int
    
    init(modelName: String) {
        self.container = NSPersistentContainer.make(modelName: modelName)
        self.numberOfLoadingStores = self.isNotStartedLoading
    }
    
    func loadStores() {
        guard !self.isLoadingStores, !self.hasLoadedStores, !self.container.persistentStoreDescriptions.isEmpty else {
            return
        }
        
        self.numberOfLoadingStores = self.container.persistentStoreDescriptions.count
        
        self.container.loadPersistentStores { [weak self] (description, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                print("__Loading... \n\(description)\n\(error)")
                assert(false, "__ERROR: it needs to delete app, because it has new data model, anr it still does not implement migration")
            }
            else {
                print("__Successfull Loading... \n\(description)")
                strongSelf.container.viewContext.name = "Main MOC: " + strongSelf.container.name
                strongSelf.container.viewContext.automaticallyMergesChangesFromParent = true
                
                strongSelf.numberOfLoadingStores -= 1
                strongSelf.delegate?.controller(strongSelf, didLoadSuccessful: description)
            }
        }
    }
}
