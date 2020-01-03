//
//  ChainPerformingActivityViewController.swift
//  sberservice
//
//  Created by User on 8/8/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class ActionSheetContainerViewController: UIViewController {
    @IBOutlet weak var safeAreaContainerView: UIView! {
        didSet {
            self.safeAreaContainerView.backgroundColor = UIColor.clear
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.backgroundColor = UIColor.clear
        }
    }

    var contentViewController: UIViewController? {
        didSet {
            self.setupContentIfPossible()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContentIfPossible()
    }
}

fileprivate extension ActionSheetContainerViewController {
    func setupContentIfPossible() {
        guard let vc = self.contentViewController, self.isViewLoaded else {
            return
        }
        
        self.addChildContainer(vc, containerSubview: self.containerView)
        
        self.safeAreaContainerView?.backgroundColor = vc.view.backgroundColor
        
        let r = vc.view.layer.cornerRadius
        self.safeAreaContainerView?.layer.cornerRadius = r
        self.containerView.layer.cornerRadius = r
    }
}
