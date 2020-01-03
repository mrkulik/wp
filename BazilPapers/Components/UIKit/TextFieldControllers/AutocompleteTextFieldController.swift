//
//  AutocompleteTextFieldController.swift
//  Internal
//
//  Created by wx on 7/20/18.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation
import UIKit

class AutocompleteTextFieldController: ChainTextFieldController {
    var isValidPhoneNumber: Bool {
        guard let text = self.textField?.text else {
            return false
        }
        
        return self.phonePredicate?.evaluate(with: text) ?? true
    }
    
    weak var textField: UITextField? {
        willSet {
            self.textField?.removeTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        }
        didSet {
            self.textField?.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        }
    }

    var digitPlaceholder: Character = "X" {
        didSet {
            self.makeInit()
        }
    }
    
    var phoneRawValue: String? {
        guard let text = self.textField?.text else {
            return nil
        }
        
        let p = text.removingMatches(regex: "[+ ()-]")
        return p
    }
    
    var phoneMask = "+7 (XXX) XXX-XX-XX" {
        didSet {
            self.makeInit()
        }
    }

    private var phonePredicate: NSPredicate? = nil
    private var inputingPhonePredicate: NSPredicate? = nil
    private let formatter = PhoneNumberAutoformatter()

    private var currentText: String? = nil
    
    init(phoneMask: String? = nil, digitalPlaceholder: Character? = nil) {
        super.init()

        if let m = phoneMask {
            self.phoneMask = m
        }
        
        if let p = digitalPlaceholder {
            self.digitPlaceholder = p
        }
        
        self.makeInit()
    }

    private func makeInit() {
        self.phonePredicate = NSPredicate.phone(phoneMask: self.phoneMask, digitPlaceholder: self.digitPlaceholder)
        self.inputingPhonePredicate = NSPredicate.inputingPhone(phoneMask: self.phoneMask, digitPlaceholder: self.digitPlaceholder)
        
        self.formatter.digitPlaceholder = self.digitPlaceholder
        self.formatter.phoneMask = self.phoneMask
    }
    
    @objc private func didChange(_ textField: UITextField) {
        let newText = textField.text ?? ""
        
        self.currentText = self.formatter.makeProcessing(newPhone: newText, oldPhone: self.currentText)

        textField.text = self.currentText
    }
    
    // MARK: - UITextFieldDelegate
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        textField.text = self.formatter.makeAutocompletion(phone: text)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.textFieldDidEndEditing(textField)

        super.textFieldDidEndEditing(textField, reason: reason)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        textField.text = self.formatter.makeAutotrimming(phone: text, removeLastDigit: false)

        super.textFieldDidEndEditing(textField)
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let superShould = super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        
        guard let p = self.inputingPhonePredicate else {
            return superShould
        }
        
        var possibleText = string
        
        if let currentText = textField.text, let r = Range(range, in: currentText) {
            possibleText = currentText.replacingCharacters(in: r, with: string)
        }

        return superShould && p.evaluate(with: possibleText)
    }
}
