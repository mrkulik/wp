//
//  NSFetchedResultsController+Utils.swift
//  Internal
//
//  Created by User on 1/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchedResultsController {
    @objc func performFetchWithDebugLog(_ info: String? = nil) {
        do {
            try self.performFetch()
        }
        catch let e {
            if let i = info {
                print("Dev info: \(i)")
            }
            
            print("NSFetchedResultsController performFetch error \n\(e)\n\(self)")
        }
    }
}
