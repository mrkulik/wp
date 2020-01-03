//
//  MaxIntTextFieldValidateController.swift
//  Internal
//
//  Created by wx on 12/1/18.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation
import UIKit

class MaxIntTextFieldValidateController: ChainTextFieldController {
    var maxInt: Int32? = 3
    
    init(maxInt: Int32? = nil) {
        super.init()
        
        self.maxInt = maxInt
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let maxIntValue = self.maxInt else {
            return true
        }
        
        var possibleText = string
        
        if let currentText = textField.text, let range = Range(range, in: currentText) {
            possibleText = currentText.replacingCharacters(in: range, with: string)
        }
        
        guard !possibleText.isEmpty else {
            return true
        }
        
        guard possibleText.hasNoZeroPrefix else {
            return false
        }
        
        guard let intValue = Int32(possibleText) else {
            return false
        }
        
        return intValue <= maxIntValue
    }
}
