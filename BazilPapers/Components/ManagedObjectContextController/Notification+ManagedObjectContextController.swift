//
//  Notification+ManagedObjectContextController.swift
//  sberservice
//
//  Created by wx on 10/18/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CoreData

extension Notification {
    var contextEvent: ManagedObjectContextEvents? {
        return ManagedObjectContextEvents.event(for: self.name)
    }
    
    var updatedManagedObjects: Set<NSManagedObject>? {
        return self.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>
    }
    
    var refreshedManagedObjects: Set<NSManagedObject>? {
        return self.userInfo?[NSRefreshedObjectsKey] as? Set<NSManagedObject>
    }
    
    var insertedManagedObjects: Set<NSManagedObject>? {
        return self.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>
    }
    
    var deletedManagedObjects: Set<NSManagedObject>? {
        return self.userInfo?[NSDeletedObjectsKey] as? Set<NSManagedObject>
    }
    
    var invalidatedManagedObjects: Set<NSManagedObject>? {
        return self.userInfo?[NSInvalidatedObjectsKey] as? Set<NSManagedObject>
    }
    
    func managedObjects(with changes: ManagedObjectChanges = .all) -> Set<NSManagedObject> {
        var set = Set<NSManagedObject>()
        
        if changes.contains(.updated), let MOs = self.updatedManagedObjects {
            set.formUnion(MOs)
        }
        
        if changes.contains(.inserted), let MOs = self.insertedManagedObjects {
            set.formUnion(MOs)
        }
        
        if changes.contains(.deleted), let MOs = self.deletedManagedObjects {
            set.formUnion(MOs)
        }
        
        if changes.contains(.invalidated), let MOs = self.invalidatedManagedObjects {
            set.formUnion(MOs)
        }
        
        if changes.contains(.refreshed), let MOs = self.refreshedManagedObjects {
            set.formUnion(MOs)
        }
        
        return set
    }
}
