//
//  SmsSecretTextField.swift
//  sberservice
//
//  Created by admin on 10/1/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

protocol SmsSecretTextFieldDelegate: UITextFieldDelegate {
    func textFieldDidDelete(_ textField: SmsSecretTextField)
}

class SmsSecretTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        super.canPerformAction(action, withSender: sender)
        return false
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        let d = self.delegate as? SmsSecretTextFieldDelegate
        d?.textFieldDidDelete(self)
    }
}
