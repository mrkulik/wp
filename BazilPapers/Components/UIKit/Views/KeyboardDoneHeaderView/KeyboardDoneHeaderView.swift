//
//  KeyboardHeaderButtonViewController.swift
//  sberservice
//
//  Created by admin on 8/8/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class KeyboardDoneHeaderView: KeyboardHeaderButtonView {
    
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            self.button = self.doneButton
        }
    }

    weak var responder: UIResponder?
    
    override func buttonDidPressed(_ sender: UIButton) {
        super.buttonDidPressed(sender)
        
        self.responder?.resignFirstResponder()
    }
}
