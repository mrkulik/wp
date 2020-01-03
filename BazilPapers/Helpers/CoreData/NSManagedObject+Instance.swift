//
//  NSManagedObject+Instance.swift
//  sberservice
//
//  Created by User on 10/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func makeInContext(of mo: NSManagedObject?) -> Self? {
        guard let context = mo?.managedObjectContext else {
            return nil
        }
        
        return self.make(context: context)
    }
    
    class private func make<ManagedObject: NSManagedObject>(context: NSManagedObjectContext) -> ManagedObject {
        return ManagedObject(context: context)
    }
}

