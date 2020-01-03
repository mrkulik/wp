//
//  NSManagedObjectContext+Utils.swift
//  Internal
//
//  Created by User on 22.12.2018.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func makeChildContext(mergesChangesFromParent: Bool = true, name: String? = nil) -> NSManagedObjectContext {
        let c = NSManagedObjectContext(concurrencyType: self.concurrencyType)
        c.parent = self
        c.automaticallyMergesChangesFromParent = mergesChangesFromParent
        c.name = name
        
        return c
    }
    
    func saveWithDebugLog(_ info: String? = nil, recursively: Bool = false) {
        do {
            if recursively {
                try self.saveRecursively()
            }
            else {
                try self.save()
            }
        }
        catch let e {
            if let i = info {
                print("Dev info: \(i)")
            }
            print("Context saving error \n\(e)\n\(self)")
        }
    }
    
    func saveRecursively() throws {
        var current: NSManagedObjectContext = self
        try current.save()
        
        while let parent = current.parent {
            try parent.save()
            current = parent
        }
    }
    
    func recursivelyRefreshAllObjectsFromParent(_ parent: NSManagedObjectContext? = nil) {
        if self.parent !== parent {
            self.parent?.recursivelyRefreshAllObjectsFromParent(parent)
        }
        
        self.refreshAllObjects()
    }
    
    func objectOrNil(with objectID: NSManagedObjectID?) -> NSManagedObject? {
        guard let id = objectID else {
            return nil
        }
        
        return self.object(with: id)
    }
    
    func delete( _ objects: [NSManagedObject]) {
        for mo in objects {
            self.delete(mo)
        }
    }
}
