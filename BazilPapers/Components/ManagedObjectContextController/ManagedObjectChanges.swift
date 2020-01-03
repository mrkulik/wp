//
//  ManagedObjectChanges.swift
//  sberservice
//
//  Created by wx on 10/18/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

struct ManagedObjectChanges: OptionSet {
    let rawValue: Int
    
    static let updated = ManagedObjectChanges(rawValue: 1 << 0)
    static let refreshed = ManagedObjectChanges(rawValue: 1 << 1)
    static let inserted = ManagedObjectChanges(rawValue: 1 << 2)
    static let deleted = ManagedObjectChanges(rawValue: 1 << 3)
    static let invalidated = ManagedObjectChanges(rawValue: 1 << 4)
    
    static let all: ManagedObjectChanges = [.updated, .inserted, .deleted, .invalidated, .refreshed]
}
