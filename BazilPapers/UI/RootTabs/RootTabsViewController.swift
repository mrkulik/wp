//
//  RootTabsViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class RootTabsViewController: UIViewController, RootNavigation {
    weak var managedTabBarController: UITabBarController?
    weak var buttonsViewController: RootTabButtonsViewController?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buttonsViewController?.managedTabBarController = self.managedTabBarController
        self.buttonsViewController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buttonsViewController?.setSelection(atIndex: .listTabIndex)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? UITabBarController {
            self.managedTabBarController = vc
        }
        else if let vc = segue.destination as? RootTabButtonsViewController {
            self.buttonsViewController = vc
        }
    }
}

extension RootTabsViewController: ButtonTabViewControllerDelegate {
    func controller(_ controller: ButtonTabViewController, shouldSelectTabAtIndex index: Int) -> Bool {
        return true
    }
}

fileprivate extension Int {
    static let listTabIndex = 0
}

