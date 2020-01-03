//
//  ChainProxyControllerDispatcher.swift
//  Internal
//
//  Created by wx on 1/29/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation

class ChainProxyControllerDispatcher {
    private (set) var proxiedChainController: ChainController
    
    private var activeProxyControllers: NSHashTable<ChainProxyController> = NSHashTable.weakObjects()
    
    init(proxiedChainController: ChainController) {
        self.proxiedChainController = proxiedChainController
        self.proxiedChainController.delegate = self
    }
    
    func makePerform(object: Any? = nil, proxyController: ChainProxyController) {
        let needsPerform = self.activeProxyControllers.isEmpty
        
        self.activeProxyControllers.add(proxyController)
        
        if needsPerform {
            self.proxiedChainController.perform(object: object)
        }
    }
}

extension ChainProxyControllerDispatcher: ChainControllerDelegate {
    func controller(_ controller: ChainController, didSuccess object: Any?) {
        guard !self.activeProxyControllers.isEmpty else {
            return
        }
        
        for proxy in self.activeProxyControllers.allObjects {
            proxy.delegate?.controller(controller, didSuccess: object)
        }
        
        self.activeProxyControllers.removeAllObjects()
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        guard !self.activeProxyControllers.isEmpty else {
            return
        }
        
        for proxy in self.activeProxyControllers.allObjects {
            proxy.delegate?.controller(controller, didFail: error)
        }
        
        self.activeProxyControllers.removeAllObjects()
    }
}

fileprivate extension NSHashTable where ObjectType == ChainProxyController {
    var isEmpty: Bool {
        return self.count == 0
    }
}


