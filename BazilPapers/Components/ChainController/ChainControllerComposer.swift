//
//  ChainControllerPassiveBarrierComposer.swift
//  Internal
//
//  Created by wx on 1/16/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

final class ChainControllerComposer: ChainController {
    var chainControllers: [ChainController]?
    
    init(controllers: [ChainController], delegate: ChainControllerDelegate?) {
        self.chainControllers = controllers
        super.init()
        self.delegate = delegate
    }
    
    override var delegate: ChainControllerDelegate? {
        didSet {
            self.chainControllers?.forEach { (c) in
                c.delegate = self.delegate
            }
        }
    }
    
    override func perform(object: Any? = nil) {
        super.perform(object: object)
        
        if let controllers = self.chainControllers, !controllers.isEmpty {
            for c in controllers {
                c.perform(object: object)
            }
        }
    }
}
