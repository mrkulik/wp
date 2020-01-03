//
//  ManagedObjectContextController.swift
//  sberservice
//
//  Created by wx on 10/18/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CoreData

class ManagedObjectContextController {
    var changes: ManagedObjectChanges = .all
    var queue = OperationQueue.main
    
    var context: NSManagedObjectContext? {
        didSet {
            self.unregister()
        }
    }
    
    private (set) var contextEvents: ManagedObjectContextEvents?
    private let center = NotificationCenter.default
    
    private var didChangeObserver: NSObjectProtocol?
    private var didSaveObserver: NSObjectProtocol?
    private var willSaveObserver: NSObjectProtocol?
    
    deinit {
        self.unregister()
    }
    
    func register(_ events: ManagedObjectContextEvents = .all) {
        self.contextEvents = events
        
        if events.contains(.objectsDidChange) {
            let n = Notification.Name.NSManagedObjectContextObjectsDidChange
            self.didChangeObserver = self.center.addObserver(forName: n, object: self.context, queue: self.queue, using: self.handleNotification(_:))
        }
        
        if events.contains(.didSave) {
            let n = Notification.Name.NSManagedObjectContextDidSave
            self.didSaveObserver = self.center.addObserver(forName: n, object: self.context, queue: self.queue, using: self.handleNotification(_:))
        }
        
        if events.contains(.willSave) {
            let n = Notification.Name.NSManagedObjectContextWillSave
            self.willSaveObserver = self.center.addObserver(forName: n, object: self.context, queue: self.queue, using: self.handleNotification(_:))
        }
    }
    
    func unregister(_ events: ManagedObjectContextEvents = .all) {
        self.contextEvents = nil
        
        if let o = self.didChangeObserver, events.contains(.objectsDidChange) {
            self.center.removeObserver(o)
        }
        
        if let o = self.didSaveObserver, events.contains(.didSave) {
            self.center.removeObserver(o)
        }
        
        if let o = self.willSaveObserver, events.contains(.willSave) {
            self.center.removeObserver(o)
        }
    }
    
    func handleNotification(_ notification: Notification) {
        // needs to be overriden
    }
}
