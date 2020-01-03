//
//  SwitchNextTextFieldController.swift
//  sberservice
//
//  Created by wx on 10/1/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

class SwitchNextTextFieldController: ChainTextFieldController, SmsSecretTextFieldDelegate {
  
    var textFields: [SmsSecretTextField]! {
        didSet {
            for tf in self.textFields {
                tf.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
            }
        }
    }
    
    private var fillAllHandler: ((String) -> Void)?
    
    func makeBecomeFirst(with fillAllFieldsHandler: @escaping (_ code: String) -> Void) {
        self.fillAllHandler = fillAllFieldsHandler
        
        self.textFields.first?.becomeFirstResponder()

    }
    
    func textFieldDidDelete(_ textField: SmsSecretTextField) {
        switch textField {
        case textFields[0]:
            textFields[0].becomeFirstResponder()
            textFields[0].text = ""
        case textFields[1]:
            textFields[0].becomeFirstResponder()
            textFields[0].text = ""
        case textFields[2]:
            textFields[1].becomeFirstResponder()
            textFields[1].text = ""
        case textFields[3]:
            textFields[2].becomeFirstResponder()
            textFields[2].text = ""
        default:
            break
        }
    }
    
    func clearTextFields() {
        textFields.forEach { (tf) in
            tf.text = ""
        }
        textFields[0].becomeFirstResponder()
    }
    
}

fileprivate extension SwitchNextTextFieldController {
    @objc func didChange(_ textField: UITextField) {
        
        
        guard let text = textField.text else {
            return
        }
        
        if text.count >= 1 {
            switch textField {
            case textFields[0]:
                textFields[1].becomeFirstResponder()
            case textFields[1]:
                textFields[2].becomeFirstResponder()
            case textFields[2]:
                textFields[3].becomeFirstResponder()
            case textFields[3]:
                textFields[3].resignFirstResponder()
                makePerformHandler()
            default:
                break
            }
        }
        
    }
    
    func makePerformHandler() {
        let code = self.textFields.compactMap { (tf) -> String? in
            return tf.text
        }
        
        self.fillAllHandler?(code.joined())
    }
}

