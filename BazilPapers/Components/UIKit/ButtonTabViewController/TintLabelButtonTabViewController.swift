//
//  TintLabelButtonTabViewController.swift
//  sberservice
//
//  Created by User on 8/12/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

class TintLabelButtonTabViewController: LabelButtonTabViewController {
    override func tabWillDeselect(with button: UIButton, atIndex index: Int) {
        super.tabWillDeselect(with: button, atIndex: index)
        
        button.setTintColorFromTitleColor(for: .normal)
        self.selectedLabel?.textColor = button.tintColor
    }
    
    override func tabDidSelect(with button: UIButton, atIndex index: Int) {
        super.tabDidSelect(with: button, atIndex: index)
        
        button.setTintColorFromTitleColor(for: .selected)
        self.selectedLabel?.textColor = button.tintColor
    }
    
    override func applyCustomTitleColors() {
        super.applyCustomTitleColors()
        
        for b in self.tabButtons {
            b.setTintColorFromCurrentTitleColor()
        }
        
        for i in 0..<self.tabButtons.count {
            self.tabLabels[i].textColor = self.tabButtons[i].tintColor
        }
    }
}

