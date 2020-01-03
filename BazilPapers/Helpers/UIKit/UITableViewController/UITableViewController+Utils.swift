//
//  UITableViewController+Utils.swift
//  Internal
//
//  Created by wx on 7/8/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    func addHeaderViewController(_ viewController: UIViewController, height: CGFloat? = nil) {
        guard self.isViewLoaded, self !== viewController.parent else {
            return
        }
        
        self.addChild(viewController)
        self.tableView.tableHeaderView = viewController.view
        viewController.didMove(toParent: self)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        viewController.view.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        viewController.view.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true

        if let height = height {
            viewController.view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        self.tableView.layoutIfNeeded()
    }
    
    func removeHeaderViewController(_ viewController: UIViewController) {
        guard self.isViewLoaded, self === viewController.parent else {
            return
        }
        
        viewController.willMove(toParent: nil)
        self.tableView.tableHeaderView = nil
        viewController.removeFromParent()

        self.tableView.layoutIfNeeded()
    }
}
