//
//  MappingManagedObjectContextController.swift
//  sberservice
//
//  Created by wx on 10/18/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CoreData

class MappingManagedObjectContextController: ManagedObjectContextController {
    private var handlers: [String:  Any] = [:]
    
    func handleEntity<ManagedObject: NSManagedObject>(toHandler handler: @escaping (_ events: ManagedObjectContextEvents, _ changes: ManagedObjectChanges, _ mo: ManagedObject) -> Void) {
        guard let name = ManagedObject.entity().name else {
            return
        }
        
        let h = {(_ events: ManagedObjectContextEvents, _ changes: ManagedObjectChanges, _ mo: NSManagedObject) in
            guard let mo = mo as? ManagedObject else {
                return
            }
            
            handler(events, changes, mo)
        }
        
        self.handlers[name] = h
    }
    
    final override func handleNotification(_ notification: Notification) {
        super.handleNotification(notification)
        
        guard let event = ManagedObjectContextEvents.event(for: notification.name) else {
            return
        }
        
        if self.changes.contains(.updated), let MOs = notification.updatedManagedObjects {
            self.makeHandle(event: event, change: .updated, MOs: MOs)
        }
        
        if self.changes.contains(.inserted), let MOs = notification.insertedManagedObjects {
            self.makeHandle(event: event, change: .inserted, MOs: MOs)
        }
        
        if self.changes.contains(.deleted), let MOs = notification.deletedManagedObjects {
            self.makeHandle(event: event, change: .deleted, MOs: MOs)
        }
        
        if self.changes.contains(.invalidated), let MOs = notification.invalidatedManagedObjects {
            self.makeHandle(event: event, change: .invalidated, MOs: MOs)
        }
        
        if self.changes.contains(.refreshed), let MOs = notification.refreshedManagedObjects {
            self.makeHandle(event: event, change: .refreshed, MOs: MOs)
        }
    }
    
    private func makeHandle(event: ManagedObjectContextEvents, change: ManagedObjectChanges, MOs: Set<NSManagedObject>) {
        MOs.forEach { (mo) in
            guard
                let name = mo.entity.name,
                let handler = self.handlers[name],
                let h = handler as? ((ManagedObjectContextEvents, ManagedObjectChanges, NSManagedObject) -> Void)
                else {
                    return
            }
            
            h(event, change, mo)
        }
    }
}
