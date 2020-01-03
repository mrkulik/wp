//
//  LayoutingFixTextFieldController.swift
//  sberservice
//
//  Created by wx on 9/30/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

class LayoutingFixTextFieldController: ChainTextFieldController {
    override func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layoutIfNeeded()
        super.textFieldDidEndEditing(textField, reason: reason)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layoutIfNeeded()
        super.textFieldDidEndEditing(textField)
    }
}


