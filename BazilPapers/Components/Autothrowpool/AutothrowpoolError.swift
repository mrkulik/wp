//
//  AutothrowpoolError.swift
//  sberservice
//
//  Created by User on 10/31/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

class AutothrowpoolError: NSError {
    var autothrowedErrors: [Error]? {
        return self.userInfo[self.domain] as? [Error]
    }

    override var localizedDescription: String {
        var message = "Code: \(self.code)"
        
        if let errors = self.autothrowedErrors as [NSError]?, !errors.isEmpty {
            for e in errors {
                message += "\n" + e.domain
            }
        }
        else {
            message += "\n" + super.localizedDescription
        }
        
        return message
    }
}
