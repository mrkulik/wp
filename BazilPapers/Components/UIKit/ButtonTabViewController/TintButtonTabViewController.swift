//
//  TintButtonTabViewController.swift
//  Internal
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class TintButtonTabViewController: ButtonTabViewController {
    override func tabWillDeselect(with button: UIButton, atIndex index: Int) {
        super.tabWillDeselect(with: button, atIndex: index)
        
        button.setTintColorFromTitleColor(for: .normal)
    }
    
    override func tabDidSelect(with button: UIButton, atIndex index: Int) {
        super.tabDidSelect(with: button, atIndex: index)
        
        button.setTintColorFromTitleColor(for: .selected)
    }
    
    override func applyCustomTitleColors() {
        super.applyCustomTitleColors()
        
        for b in self.tabButtons {
            b.setTintColorFromCurrentTitleColor()
        }
    }
}
