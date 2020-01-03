//
//  PredicateValidateTextFieldController.swift
//  Internal
//
//  Created by wx on 4/4/19.
//  Copyright © 2019 wx. All rights reserved.
//

import UIKit

class PredicateValidateTextFieldController: ChainTextFieldController {
    var predicate: NSPredicate? = nil
    
    // MARK: - Life Cycle
    override init() {
        super.init()
    }
    
    init(regexMask: String) {
        super.init()
        
        self.setRegexMask(regexMask)
    }
    
    init(predicate: NSPredicate) {
        super.init()
        
        self.predicate = predicate
    }
    
    func setRegexMask( _ mask: String) {
        self.predicate = NSPredicate.matchString(toRegex: mask)
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let superShould = super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        
        guard let p = self.predicate else {
            return superShould
        }
        
        var possibleText = string
        
        if let currentText = textField.text, let r = Range(range, in: currentText) {
            possibleText = currentText.replacingCharacters(in: r, with: string)
        }
        
        return superShould && p.evaluate(with: possibleText)
    }
}
