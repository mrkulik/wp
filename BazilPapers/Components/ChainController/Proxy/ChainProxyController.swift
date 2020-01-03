//
//  ChainProxyController.swift
//  Internal
//
//  Created by wx on 1/29/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

/*
 Usage:
 
 extension MySpecificChainController {
    private static let dispatcher = ChainProxyControllerDispatcher(proxiedChainController: MySpecificChainController())
 
    static var makeProxyController: ChainProxyController {
        let c = ChainProxyController(dispatcher: self.dispatcher)
        return c
    }
 }

 extension ChainProxyController {
    var mySpecificChainController: MySpecificChainController? {
        return self.proxiedController as? MySpecificChainController
    }
 }
 
 let singleInstance = MySpecificChainController.makeProxyController
 let original = singleInstance.mySpecificChainController
 
 */


class ChainProxyController: ChainController {
    private weak var dispatcher: ChainProxyControllerDispatcher?
    
    var proxiedController: ChainController? {
        return self.dispatcher?.proxiedChainController
    }
    
    override var nextController: ChainController? {
        didSet {
            self.dispatcher?.proxiedChainController.nextController = self.nextController
        }
    }
    
    init(dispatcher: ChainProxyControllerDispatcher) {
        self.dispatcher = dispatcher
    }
    
    override func perform(object: Any? = nil) {
        self.dispatcher?.makePerform(object: object, proxyController: self)
    }
}
