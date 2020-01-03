//
//  TintButtonTabViewController.swift
//  sberservice
//
//  Created by User on 8/12/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
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
