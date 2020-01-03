//
//  ChainPerformingResultActivityViewController.swift
//  sberservice
//
//  Created by User on 8/8/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class ChainPerformingResultActivityViewController: ChainPerformingResultViewController {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?
    
    override func makeStartPerformingIndicatorAnimation() {
        super.makeStartPerformingIndicatorAnimation()
     
        activityIndicatorView?.startAnimating()
        activityIndicatorView?.isHidden = false
    }
    
    override func makeStopPerformingIndicatorAnimation() {
        super.makeStopPerformingIndicatorAnimation()
        
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.isHidden = true
    }
}
