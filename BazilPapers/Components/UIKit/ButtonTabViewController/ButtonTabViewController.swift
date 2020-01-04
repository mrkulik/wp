//
//  ButtonTabViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//


import UIKit

/*
 
 Usage:
 For example you have class MyButtonTabViewController
 
 1. Subclass MyButtonTabViewController from ButtonTabViewController

 MyButtonTabViewController: ButtonTabViewController {}
 
 2. Make storyboard just for MyButtonTabViewController like initial view controller,
 and turn on outlet collection for your myTabButtons like following:

 @IBOutlet var myTabButtons: [UIButton]! {
    didSet {
        self.tabButtons = self.myTabButtons
    }
 }
 
 3. Make one more storyboard which contains two container views:
 - first one for MyButtonTabViewController by Storyboard reference
 - second one for UITabBarController
 
 NOTE!!: TabBarController must containt the same number of tabs
 like number of buttons in MyButtonTabViewController storyboard
 
 
 4. Tune your MyButtonTabViewController instance with UITabBarController instance in viewDidLoad()
 
 weak var myButtonTabVC: MyButtonTabViewController?
 weak var rootTabBarController: UITabBarController?
 
 override func viewDidLoad() {
    super.viewDidLoad()
    self.myButtonTabVC.managedTabBarController = self.rootTabBarController
 }
 
 5. Also you can use ButtonTabViewControllerDelegate events
 
 */

@objc protocol ButtonTabViewControllerDelegate: class {
    @objc optional func controller(_ controller: ButtonTabViewController, shouldSelectTabAtIndex index: Int) -> Bool
    @objc optional func controller(_ controller: ButtonTabViewController, didSelectTabAtIndex index: Int)
}

class ButtonTabViewController: UIViewController {
    weak var delegate: ButtonTabViewControllerDelegate?
    weak var managedTabBarController: UITabBarController?

    var tabButtons: [UIButton] = []
    
    private (set) weak var selectedButton: UIButton?
    
    var isSwitchable = true

    var needsConfigureAllTabsLikeFirst = true
    
    var normalColor: UIColor? = .blue
    var selectedColor: UIColor? = .red
    var highlightedColor: UIColor? = .yellow
    var disabledColor: UIColor? = .gray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setButtonTextAlignment()
        self.setInitialSelection()
        
        for b in self.tabButtons {
            b.addTarget(self, action: #selector(self.touchDown(_:)), for: .touchDown)
            b.addTarget(self, action: #selector(self.touchUpOutside(_:)), for: .touchUpOutside)
            b.addTarget(self, action: #selector(self.touchUpInside(_:)), for: .touchUpInside)
        }
        
        self.makeConfigureAllButtonsLikeFirstIfNeeded()
    }
    
    // MARK: - Dynamic Actions
    @objc private func touchDown(_ sender: UIButton) {
        self.highlight(sender: sender)
    }
    
    @objc private func touchUpOutside(_ sender: UIButton) {
        self.unhighlight(sender: sender)
    }
    
    @objc private func touchUpInside(_ sender: UIButton) {
        self.unhighlight(sender: sender)
        self.changeSelectedTabIfNeeded(sender)
    }
    
    // MARK: - Helpers
    private func changeSelectedTabIfNeeded(_ sender: UIButton) {
        guard self.selectedButton !== sender, self.isSwitchable else {
            return
        }
        
        let index: Int! = self.tabButtons.firstIndex(of: sender)
        let should = self.delegate?.controller?(self, shouldSelectTabAtIndex: index) ?? true
        
        guard should else {
            return
        }
        
        self.managedTabBarController?.selectedIndex = index
        
        if let b = self.selectedButton, let i = self.tabButtons.firstIndex(of: b) {
            self.tabWillDeselect(with: b, atIndex: i)
        }
        
        self.tabDidSelect(with: sender, atIndex: index)
        
        self.delegate?.controller?(self, didSelectTabAtIndex: index)
    }
    
    func highlight(sender: UIButton) {
        
    }

    func unhighlight(sender: UIButton) {
        
    }

    func tabWillDeselect(with button: UIButton, atIndex index: Int) {
        button.isSelected = false
    }
    
    func tabDidSelect(with button: UIButton, atIndex index: Int) {
        button.isSelected = true
        self.selectedButton = button
    }

    func setInitialSelection(atIndex index: Int = 0) {
        guard index >= 0, index < self.tabButtons.count else {
            return
        }
        
        let button = self.tabButtons[index]
        button.isSelected = true
        self.selectedButton = button
        
        self.managedTabBarController?.selectedIndex = index
    }

    func setSelection(atIndex index: Int) {
        guard index >= 0, index < self.tabButtons.count else {
            return
        }

        self.managedTabBarController?.selectedIndex = index
        
        if let b = self.selectedButton, let i = self.tabButtons.firstIndex(of: b) {
            self.tabWillDeselect(with: b, atIndex: i)
        }
        
        let button = self.tabButtons[index]
        self.tabDidSelect(with: button, atIndex: index)
    }
    
    func removeSelection() {
        self.selectedButton?.isSelected = false
        self.selectedButton = nil
    }
    
    func applyCustomTitleColors() {
        guard let b = self.tabButtons.first else {
            return
        }
        
        if let n = self.normalColor {
            b.setTitleColor(n, for: .normal)
        }
        
        if let s = self.selectedColor {
            b.setTitleColor(s, for: .selected)
        }
        
        if let h = self.highlightedColor {
            b.setTitleColor(h, for: .highlighted)
        }
        
        if let d = self.disabledColor {
            b.setTitleColor(d, for: .disabled)
        }

        self.makeConfigureAllButtonsLikeFirstIfNeeded()
    }
    
    
    final func setButtonTextAlignment(_ alignment: NSTextAlignment = .center) {
        for b in self.tabButtons {
            b.titleLabel?.textAlignment = alignment
        }
    }
}

fileprivate extension ButtonTabViewController {
    func makeConfigureAllButtonsLikeFirstIfNeeded() {
        guard !self.tabButtons.isEmpty, self.needsConfigureAllTabsLikeFirst else {
            return
        }
        
        var buttons = self.tabButtons
        let first = buttons.removeFirst()
        
        for b in buttons {
            b.setTitleColor(from: first, for: .normal)
            b.setTitleColor(from: first, for: .selected)
            b.setTitleColor(from: first, for: .highlighted)
            b.setTitleColor(from: first, for: .disabled)
        }
    }
}

extension UIButton {
    func setTitleColor(from button: UIButton, for state: UIControl.State) {
        let color = button.titleColor(for: state)
        self.setTitleColor(color, for: state)
    }
    
    func setTintColorFromCurrentTitleColor() {
        self.tintColor = self.currentTitleColor
    }

    func setTintColorFromTitleColor(for state: UIControl.State) {
        self.tintColor = self.titleColor(for: state)
    }
    
    
}
