//
//  ChainPerformingResultViewController.swift
//  sberservice
//
//  Created by wx on 9/24/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit
import Foundation

class ChainPerformingResultViewController: ChainPerformingViewController, UseCustomPresentationController {
    var transitionController: UIViewControllerTransitioningDelegate = BottomTransitionController()
    
    var successViewController: UIViewController?
    var failViewController: UIViewController?
    
    var codeViewControllers: [Int: UIViewController] = [:]
    
    private var successHandler: (() -> Void)?
    
    func setHandlerOnSuccess(_ handler: @escaping () -> Void) {
        self.successHandler = handler
    }
    
    override func controller(_ controller: ChainController, didSuccess object: Any?) {
        if let vc = self.successViewController {
            self.presentWithCustomStyle(vc, transitionStyle: .coverVertical)
            super.controller(controller, didSuccess: object)
        }
        else {
            self.dismiss(animated: true) {
                self.successHandler?()
                super.controller(controller, didSuccess: object)
            }
        }
    }
    
    override func controller(_ controller: ChainController, didFail error: Error?) {
        var codeVC: UIViewController? = nil
        if let e = error as NSError? {
            codeVC = self.codeViewControllers[e.code]
        }
        
        if let vc = codeVC ?? self.failViewController {
            self.presentWithCustomStyle(vc, transitionStyle: .coverVertical)
            super.controller(controller, didFail: error)
        }
        else {
            self.dismiss(animated: true) {
                super.controller(controller, didFail: error)
            }
        }
    }
}

