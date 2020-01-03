//
//  ChainControllerPassiveBarrierComposer.swift
//  Internal
//
//  Created by wx on 1/18/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

final class ChainControllerPassiveBarrierComposer: ChainController {
    var chainControllers: [ChainController]? {
        didSet {
            self.chainControllers?.forEach { (c) in
                c.delegate = self
                self.performingControllers.add(c)
            }
        }
    }
    
    private var performingControllers: NSMutableSet = NSMutableSet()
    
    private func finilizeBarrierIfPossible(controller: ChainController) {
        self.performingControllers.remove(controller)

        if self.performingControllers.isEmpty {
            self.notifyAboutSuccess()
            super.perform()
        }
    }
}

extension ChainControllerPassiveBarrierComposer: ChainControllerDelegate {
    func controller(_ controller: ChainController, didSuccess object: Any?) {
        self.delegate?.controller(controller, didSuccess: object)
        
        self.finilizeBarrierIfPossible(controller: controller)
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        self.delegate?.controller(controller, didFail: error)
        
        self.finilizeBarrierIfPossible(controller: controller)
    }
}
