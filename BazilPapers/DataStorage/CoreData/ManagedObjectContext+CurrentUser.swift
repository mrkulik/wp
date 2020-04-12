//
//  ManagedObjectContext+CurrentUser.swift
//  BazilPapers
//
//  Created by Kulik on 4/12/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import CoreData


extension NSManagedObjectContext {
    var currentUser: MOUser {
        let request: NSFetchRequest<MOUser> = MOUser.fetchRequest()
        let result = try? self.fetch(request)
        if let user = result?.first {
            return user
        }
        else {
            let user = MOUser(context: self)
            try? self.save()
            return user
        }
    }
}
