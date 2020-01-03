//
//  UIViewController+Present.swift
//  Internal
//
//  Created by wx on 7/28/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentPopupByNavigationController( _ viewController: UIViewController, completion: (() -> Swift.Void)? = nil) {
        let nc = self.presentByNavigationController(viewController, completion: completion)
        nc.view.backgroundColor = UIColor.clear
        nc.modalPresentationStyle = .overCurrentContext
    }

    func presentByNavigationController(_ viewController: UIViewController, hideNavigationBar: Bool = true, animated: Bool = true, completion: (() -> Swift.Void)? = nil) -> UINavigationController {
        let nc = UINavigationController(rootViewController: viewController)
        nc.navigationBar.isHidden = hideNavigationBar
        
        DispatchQueue.main.async { [weak self] in
            self?.present(nc, animated: animated, completion: completion)
        }
        
        return nc
    }
    
    func presentAlert(title: String? = nil,
                      message: String? = nil,
                      preferredStyle: UIAlertController.Style = .alert,
                      cancelTitle: String = NSLocalizedString("Cancel", comment: "Simple Alert: cancel btn title"),
                      cancelStyle: UIAlertAction.Style = .cancel,
                      cancelHandler: ((UIAlertAction) -> ())? = nil,
                      otherActions: [UIAlertAction]? = nil,
                      animated: Bool = true,
                      completion: (() -> ())? = nil) {
        
        
        DispatchQueue.main.async { [weak self] in
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            
            alert.addAction(UIAlertAction(title: cancelTitle, style: cancelStyle, handler: cancelHandler))
            otherActions?.forEach { alert.addAction($0) }
            
            self?.present(alert, animated: animated, completion: completion)
        }
    }
    
    func presentPopup( _ viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: animated, completion: completion)
    }

    //TODO: Make this code better
    func dissmissAndPresentViewController( _ viewController: UIViewController, animated: Bool = true) {
        CATransaction.begin()
        self.dismiss(animated: animated, completion: nil)
        self.present(viewController, animated: animated, completion: nil)
        CATransaction.commit()
    }
}
