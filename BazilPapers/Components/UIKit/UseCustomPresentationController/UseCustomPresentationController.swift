//
//  UseCustomPresentationController.swift
//  sberservice
//
//  Created by wx on 9/27/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

typealias CustomPresentationController = (UIViewController & UseCustomPresentationController)

protocol UseCustomPresentationController {
    var transitionController: UIViewControllerTransitioningDelegate { get }
}

extension UseCustomPresentationController where Self: UIViewController {
    func presentWithCustomStyle(_ viewController: UIViewController, transitionStyle: UIModalTransitionStyle) {
        viewController.transitioningDelegate = self.transitionController
        viewController.modalPresentationStyle = .custom
        viewController.modalTransitionStyle = transitionStyle
        
        self.present(viewController, animated: true, completion: nil)
    }
}

