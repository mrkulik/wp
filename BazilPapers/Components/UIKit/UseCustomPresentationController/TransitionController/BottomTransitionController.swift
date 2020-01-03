//
//  BottomTransitionController.swift
//  sberservice
//
//  Created by wx on 9/30/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

class BottomTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    let topView = UIView()
    
    override init() {
        super.init()
        
        self.topView.backgroundColor = .clear
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let pc = BottomPresentationController(presentedViewController: presented, presenting: presenting)
        pc.containerSubview = self.topView
        
        return pc
    }
}

