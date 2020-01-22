//
//  Array+NSManagedObject.swift
//  Internal
//
//  Created by wx on 2/3/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import CoreData

extension Array where Element: NSManagedObject {
    func allObjectsAndIDs(byKeyPath keyPath: String) -> [String: Element] {
        var dict: [String: Element] = [:]
        
        for object in self {
            if let id = object.value(forKey: keyPath) {
                let id = id as! String
                dict[id] = object
            }
        }
        
        return dict
    }

    func sorted(by descriptors: [NSSortDescriptor]) -> [Element] {
        let result = self.sorted { (mo1, mo2) -> Bool in
            
            var i = 0
            var result = ComparisonResult.orderedSame
            
            while i < descriptors.count, result == ComparisonResult.orderedSame {
                result = descriptors[i].compare(mo1, to: mo2)
                i += 1
            }

            return result == ComparisonResult.orderedAscending
        }
        
        return result
    }
}
