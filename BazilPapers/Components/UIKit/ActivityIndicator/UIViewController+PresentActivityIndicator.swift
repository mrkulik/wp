//
//  UIViewController+PresentActivityIndicator.swift
//  Internal
//
//  Created by wx on 7/6/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func presentActivityIndicator(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        let vc = ActivityIndicatorViewController.initial()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: animated, completion: completion)
    }
    
    func dissmissActivityIndicator(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        self.dismiss(animated: animated, completion: completion)
    }
}
