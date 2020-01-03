//
//  ChainPerformingViewController.swift
//  Internal
//
//  Created by wx on 7/5/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit
//import QuartzCore

class ChainPerformingViewController: UIViewController, ChainControllerDelegate {
    
    var chainController: ChainController! {
        didSet {
            self.chainController?.delegate = self
        }
    }
    
    var nextChainControllerDelegate: ChainControllerDelegate?
    
    private (set) var isPerforming = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makePerformIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isPerforming {
            self.makeStartPerformingIndicatorAnimation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.makeStopPerformingIndicatorAnimation()
    }
    
    // MARK: - Public
    final func makePerformIfNeeded() {
        guard !self.isPerforming, self.chainController != nil else {
            return
        }
        
        self.isPerforming = true
        
        self.chainController?.perform()
    }
    
    // MARK: - Should be overriden
    func makeStartPerformingIndicatorAnimation() {
        
    }
    
    func makeStopPerformingIndicatorAnimation() {
        
    }

    func controller(_ controller: ChainController, didSuccess object: Any?) {
        self.makeStopPerformingIndicatorAnimation()

        self.nextChainControllerDelegate?.controller(controller, didSuccess: object)
    }
    
    func controller(_ controller: ChainController, didFail error: Error?) {
        self.makeStopPerformingIndicatorAnimation()
        
        self.nextChainControllerDelegate?.controller(controller, didFail: error)
    }
}
