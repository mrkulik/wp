//
//  ChainTextFieldController.swift
//  Internal
//
//  Created by wx on 10/23/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

class ChainTextFieldController: NSObject, UITextFieldDelegate {
    var nextDelegate: UITextFieldDelegate?
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let should = self.nextDelegate?.textFieldShouldBeginEditing?(textField) ?? true
        return should
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nextDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let should = self.nextDelegate?.textFieldShouldEndEditing?(textField) ?? true
        return should
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.nextDelegate?.textFieldDidEndEditing?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.nextDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let should = self.nextDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
        return should
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let should = self.nextDelegate?.textFieldShouldClear?(textField) ?? true
        return should
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let should = self.nextDelegate?.textFieldShouldReturn?(textField) ?? true
        return should
    }
    
    
}
