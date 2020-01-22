//
//  NSPersistentContainer+Models.swift
//  BazilPapers
//
//  Created by Kulik on 1/11/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import CoreData

extension NSPersistentContainer {
    class func make(modelName: String) -> NSPersistentContainer {
        let rootDirectory = "CoreData"
        let directoryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last?.appendingPathComponent(rootDirectory, isDirectory: true)
        let url = directoryUrl?.appendingPathComponent(modelName).appendingPathExtension("sqlite")
        
        let description = NSPersistentStoreDescription()
        description.url = url
        description.type = NSSQLiteStoreType
        
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [
            description
        ]
        
        return container
    }
}
