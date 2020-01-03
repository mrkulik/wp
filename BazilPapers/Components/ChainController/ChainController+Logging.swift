//
//  ChainController+Logging.swift
//  sberservice
//
//  Created by User on 9/7/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

protocol ChainControllerLoggingDelegate: ChainControllerDelegate {
    func controller(_ controller: ChainController, didLog message: String)
}

extension ChainController {
    func notifyWithLogMessage( _ message: String) {
        let logDelegate = self.delegate as? ChainControllerLoggingDelegate
        logDelegate?.controller(self, didLog: message)
    }
}
