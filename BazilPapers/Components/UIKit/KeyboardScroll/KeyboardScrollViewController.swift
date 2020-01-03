//
//  KeyboardScrollViewController.swift
//  Internal
//
//  Created by wx on 7/23/18.
//  Copyright © 2019 wx. All rights reserved.
//

import UIKit

class KeyboardScrollViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBottomOffset: NSLayoutConstraint!
    
    private let keyboardController = KeyboardBottomOffsetController()
    
    var contentViewController: UIViewController? {
        didSet {
            self.makeInitIfPossible()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.makeInitIfPossible()
    }
}

fileprivate extension KeyboardScrollViewController {
    func makeInitIfPossible() {
        guard let vc = self.contentViewController, self.isViewLoaded else {
            return
        }

        self.addChildContainer(vc, containerSubview: self.containerView)
        
        self.view.backgroundColor = vc.view.backgroundColor
        self.scrollView.showsVerticalScrollIndicator = true
        self.keyboardController.superView = self.view
        self.keyboardController.bottomOffset = self.scrollViewBottomOffset
    }
}
