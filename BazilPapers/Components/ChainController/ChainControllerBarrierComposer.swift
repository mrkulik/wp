//
//  ChainControllerPassiveBarrierComposer.swift
//  Internal
//
//  Created by wx on 1/17/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

// it sets & uses itself as signle delegate for all composed controllers
final class ChainControllerBarrierComposer: ChainController {
    var chainControllers: [ChainController]? {
        didSet {
            self.chainControllers?.forEach { (c) in
                c.delegate = self
            }
        }
    }
    
    private var performingControllers: NSMutableSet = NSMutableSet()
    
    override func perform(object: Any? = nil) {
        guard self.performingControllers.isEmpty else {
            return
        }
        
        if let controllers = self.chainControllers, !controllers.isEmpty {
            for c in controllers {
                c.perform(object: object)
                self.performingControllers.add(c)
            }
        }
        else {
            super.perform(object: object)
        }
    }
    
    private func finilizeBarrierIfPossible(controller: ChainController) {
        self.performingControllers.remove(controller)
        if self.performingControllers.isEmpty {
            self.notifyAboutSuccess()
            super.perform()
        }
    }
}

extension ChainControllerBarrierComposer: ChainControllerDelegate {
    func controller(_ controller: ChainController, didSuccess object: Any?) {
        self.delegate?.controller(controller, didSuccess: object)
        
        self.finilizeBarrierIfPossible(controller: controller)
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        self.delegate?.controller(controller, didFail: error)
        
        self.finilizeBarrierIfPossible(controller: controller)
    }
}
