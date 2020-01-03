//
//  RootTabButtonViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import UIKit


class RootTabButtonsViewController: TintLabelButtonTabViewController {
    @IBOutlet var titleLabels: [UILabel]! {
        didSet {
            self.tabLabels = self.titleLabels
        }
    }
    
    @IBOutlet var buttons: [UIButton]! {
        didSet {
            self.tabButtons = self.buttons
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selected = UIColor.systemBlue
        let normal = UIColor.systemGray
        
        self.selectedColor = selected
        self.highlightedColor = nil
        self.disabledColor = normal
        self.normalColor = normal
        
        self.applyCustomTitleColors()
    }
}
