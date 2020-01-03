//
//  RootNavigationViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//


import UIKit

class RootNavigationController: UINavigationController {
    let rootTabsViewController = RootTabsViewController.initial()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = .black
        self.view.backgroundColor = .white

        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ]
        
        self.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setRootTabs(animated: Bool = true) {
        self.setViewControllers([self.rootTabsViewController], animated: animated)
    }

}
