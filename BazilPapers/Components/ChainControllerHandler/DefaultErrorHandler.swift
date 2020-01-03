//
//  DefaultErrorHandler.swift
//  sberservice
//
//  Created by User on 10/3/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class ChainControllerHandler: ChainControllerDelegate {
    weak var nextChainControllerHandler: ChainControllerDelegate?

    func controller(_ controller: ChainController, didSuccess object: Any?) {
        self.nextChainControllerHandler?.controller(controller, didSuccess: object)
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        self.nextChainControllerHandler?.controller(controller, didFail: error)
    }
}


class DefaultErrorHandler: ChainControllerHandler {
    weak var presentingViewController: UIViewController?
    
    override func controller(_ controller: ChainController, didFail error: Error?) {
        let title = "Ошибка"
        
        self.presentingViewController?.presentAlert(title: title, message: error?.localizedDescription)

        super.controller(controller, didFail: error)
    }
}
