//
//  ManagedObjectContextEvents.swift
//  sberservice
//
//  Created by wx on 10/18/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

struct ManagedObjectContextEvents: OptionSet {
    let rawValue: Int
    
    static let objectsDidChange = ManagedObjectContextEvents(rawValue: 1 << 0)
    static let didSave = ManagedObjectContextEvents(rawValue: 1 << 1)
    static let willSave = ManagedObjectContextEvents(rawValue: 1 << 2)
    
    static let all: ManagedObjectContextEvents = [.objectsDidChange, .didSave, .willSave]
    
    static func event(for notificationName: Notification.Name) -> ManagedObjectContextEvents? {
        switch notificationName {
            
        case Notification.Name.NSManagedObjectContextObjectsDidChange:
            return .objectsDidChange
            
        case Notification.Name.NSManagedObjectContextDidSave:
            return .didSave
            
        case Notification.Name.NSManagedObjectContextWillSave:
            return .willSave
            
        default:
            return nil
        }
    }
}
