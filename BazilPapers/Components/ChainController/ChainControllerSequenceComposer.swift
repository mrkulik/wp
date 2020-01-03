//
//  ChainControllerSequenceComposer.swift
//  sberservice
//
//  Created by User on 10/4/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

final class ChainControllerSequenceComposer: ChainController {
    var chainControllers: [ChainController]? {
        didSet {
            var stack = self.chainControllers ?? []
            var next: ChainController? = nil
            
            while let current = stack.popLast() {
                current.delegate = self
                current.nextController = next
                next = current
            }
        }
    }
    
    override func perform(object: Any? = nil) {
        super.perform(object: object)
        
        self.chainControllers?.first?.perform(object: object)
    }
}

extension ChainControllerSequenceComposer: ChainControllerDelegate {
    func controller(_ controller: ChainController, didSuccess object: Any?) {
        guard controller === self.chainControllers?.last else {
            return
        }
        
        self.notifyAboutSuccess(object: object)
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        self.notifyAboutFail(error: error)
    }
}
