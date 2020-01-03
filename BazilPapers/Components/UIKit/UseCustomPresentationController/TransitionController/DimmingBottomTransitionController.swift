//
//  DimmingBottomTransitionController.swift
//  Internal
//
//  Created by wx on 6/11/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit
import Foundation

class DimmingBottomTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    
    let dimmingTopView = UIView()
    
    override init() {
        super.init()
        self.dimmingTopView.backgroundColor = .red
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let pc = DimmingBottomPresentationController(presentedViewController: presented, presenting: presenting)
        pc.dimmingView = self.dimmingTopView
        
        return pc
    }
}
