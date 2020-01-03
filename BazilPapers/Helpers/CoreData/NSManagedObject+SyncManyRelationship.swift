//
//  NSManagedObject+SyncManyRelationship.swift
//  sberservice
//
//  Created by User on 10/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    func syncManyRelation<Destination: NSManagedObject>(name: String, withDictionaries dictionaries: [[String: Any]], mapper: (_ source: [String: Any], _ destination: Destination) -> Bool) {
        self.syncManyRelation(name: name, with: dictionaries, mapper: mapper)
    }
    
    func syncManyRelation<Source, Destination: NSManagedObject>(name: String, with sources: [Source], mapper: (_ source: Source, _ destination: Destination) -> Bool) {
        guard
            let relation = self.entity.relationshipsByName[name],
            let inverseName = relation.inverseRelationship?.name,
            let value = self.value(forKey: name) else {
                return
        }
        
        var relationMOs: [Destination]?
        
        if relation.isOrdered {
            relationMOs = (value as? NSOrderedSet)?.array as? [Destination]
        }
        else {
            relationMOs = (value as? NSSet)?.allObjects as? [Destination]
        }
        
        var sources = sources
        while !sources.isEmpty {
            
            if let mo = relationMOs?.removeFirstIfExist() ?? Destination.makeInContext(of: self) {
                mo.setValue(self, forKey: inverseName)

                var isMapped = false
                
                while let s = sources.removeFirstIfExist(), !isMapped {
                    isMapped = mapper(s, mo)
                }
                
                if !isMapped {
                    relationMOs?.append(mo)
                }
            }
        }
        
        while let mo = relationMOs?.popLast() {
            mo.setValue(nil, forKey: inverseName)
            self.managedObjectContext?.delete(mo)
        }
    }
}
