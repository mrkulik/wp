//
//  LabelButtonTabViewController.swift
//  Internal
//
//  Created by wx on 30.05.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

class LabelButtonTabViewController: ButtonTabViewController {
    var tabLabels: [UILabel] = []
    
    private (set) weak var selectedLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(self.tabLabels.count == self.tabButtons.count, "__ERROR: Number of labels must be equal to number of buttons")
        self.setLabelTextColorsFromButtons()
    }
    
    // MARK: - Dynamic Actions
    override func highlight(sender: UIButton) {
        super.highlight(sender: sender)

        self.tuneLabelTextColor(with: sender)
    }

    override func unhighlight(sender: UIButton) {
        super.unhighlight(sender: sender)

        let state: UIControl.State = sender === self.selectedButton ? .selected : .normal
        self.tuneLabelTextColor(with: sender, state: state)
    }
    
    override func tabWillDeselect(with button: UIButton, atIndex index: Int) {
        super.tabWillDeselect(with: button, atIndex: index)
        
        self.selectedLabel?.textColor = button.titleColor(for: .normal)
    }
    
    override func tabDidSelect(with button: UIButton, atIndex index: Int) {
        super.tabDidSelect(with: button, atIndex: index)
        
        self.selectedLabel = self.tabLabels[index]

        self.selectedLabel?.textColor = button.titleColor(for: .selected)
    }
    
    override func setInitialSelection(atIndex index: Int = 0) {
        super.setInitialSelection(atIndex: index)
        
        self.selectedLabel = self.tabLabels[index]
    }

    override func applyCustomTitleColors() {
        super.applyCustomTitleColors()
        
        self.setLabelTextColorsFromButtons()
    }

    func tuneLabelTextColor(with button: UIButton, state: UIControl.State? = nil) {
        let index: Int! = self.tabButtons.firstIndex(of: button)
        
        let label = self.tabLabels[index]
        
        if let s = state {
            label.textColor = button.titleColor(for: s)
        }
        else {
            label.textColor = button.currentTitleColor
        }
    }
}

// MARK: - Helpers
fileprivate extension LabelButtonTabViewController {
    func setLabelTextColorsFromButtons() {
        for i in 0..<self.tabButtons.count {
            self.tabLabels[i].textColor = self.tabButtons[i].currentTitleColor
        }
    }
}
















