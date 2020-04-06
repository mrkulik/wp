//
//  UseBottomButton.swift
//  Internal
//
//  Created by wx on 8/26/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit
import Foundation

/*

 Usage:
 For example you have class MyViewController and it has bottom button

 1. Subclass your MyBottomButtonViewController from CommonButtonViewController
 
 MyBottomButtonViewController: CommonButtonViewController {}

 2. Make storyboard just for MyBottomButtonViewController like initial view controller,
 and turn on outlet for your myButton like following:
 
 @IBOutlet weak var myButton: UIButton! {
    didSet {
        self.button = self.myButton
    }
 }

 3. Inherit this protocol
 class MyViewController: UIViewController, UseBottomButton {
    var bottomButtonViewController: BottomButtonViewController!
 
    func commonBottomButtonDidPressed() {
        // here you may handle button pressed action
    }
 }
 
 4. Call setup methods in viewDidLoad()
 class MyViewController: UIViewController, UseBottomButton {
    var bottomButtonViewController: BottomButtonViewController!
 
    @IBOutlet weak var myRootView: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let vc = MyBottomButtonViewController.initial()
        self.setupBottomButtonViewController(vc, height: 50)
        self.setupBottomButtonViewTopConstraint(to: self.myRootView, offset: 5)
    }
 
    func commonBottomButtonDidPressed() {
        // here you may handle button pressed action
    }
 }
*/

protocol UseBottomButton: CommonButtonViewControllerDelegate {
    var bottomButtonViewController: CommonButtonViewController! { get set }
}
    
 
    

extension UseBottomButton where Self: UIViewController {
    var bottomView: UIView {
        return self.bottomButtonViewController.view
    }

    var bottomButton: UIButton {
        return self.bottomButtonViewController.button
    }
    
    func setupBottomButtonViewController(_ viewController: CommonButtonViewController, height: CGFloat) {
        self.setupBottomButtonViewController(viewController)
        self.setupBottomButtonViewConstraints(height: height)
    }
    
    func setupBottomButtonViewController( _ viewController: CommonButtonViewController) {
        self.bottomButtonViewController = viewController
        
        self.addChild(self.bottomButtonViewController)
        self.view.addSubview(self.bottomButtonViewController.view)
        self.bottomButtonViewController.didMove(toParent: self)
        
        self.bottomButtonViewController.delegate = self
    }
    
    func setupBottomButtonViewConstraints(height: CGFloat) {
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.bottomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.bottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupBottomButtonTitle(title: NSAttributedString) {
        self.bottomButton.setAttributedTitle(title, for: .normal)
    }
    
    func setupBottomButtonViewTopConstraint(to view: UIView, offset: CGFloat = 0) {
        _ = self.setupBottomButtonViewTopConstraintAndReturn(to: view, offset: offset)
    }

    func setupBottomButtonViewTopConstraintAndReturn(to view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        let c = view.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor)
        c.isActive = true
        c.constant = offset
        return c
    }
}
