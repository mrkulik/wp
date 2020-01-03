//
//  ActivityIndicatorViewController.swift
//  Internal
//
//  Created by wx on 20.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.activityIndicatorView.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.activityIndicatorView.stopAnimating()
    }
}
