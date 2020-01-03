//
//  TextFieldControllerComposer.swift
//  Internal
//
//  Created by wx on 10/23/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

class TextFieldControllerComposer: ChainTextFieldController {
    enum LogicalType: UInt {
        case and
        case or
    }
    
    var logicalType: LogicalType = .and
    
    var controllers: [ChainTextFieldController] = []

    // MARK: - Life Cycle
    override init() {
        super.init()
    }
    
    init(orValidators validateControllers: ChainTextFieldController...) {
        super.init()
        
        self.logicalType = .or
        self.controllers = validateControllers
    }
    
    init(andValidators validateControllers: ChainTextFieldController...) {
        super.init()
        
        self.logicalType = .and
        self.controllers = validateControllers
    }
    
    // MARK: - UITextFieldDelegate Events
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        self.controllers.forEach { (c) in
            c.textFieldDidBeginEditing(textField)
        }
        
        super.textFieldDidBeginEditing(textField)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        self.controllers.forEach { (c) in
            c.textFieldDidEndEditing(textField)
        }

        super.textFieldDidEndEditing(textField)
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.controllers.forEach { (c) in
            c.textFieldDidEndEditing(textField, reason: reason)
        }

        super.textFieldDidEndEditing(textField, reason: reason)
    }

    // MARK: - UITextFieldDelegate Permissions
    override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var should = super.textFieldShouldBeginEditing(textField)
        
        should = self.checkIfTextField(superShould: should, shouldPerformAction: { (controller) -> Bool in
            return controller.textFieldShouldBeginEditing(textField)
        })
        
        return should
    }
    
    override func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var should = super.textFieldShouldEndEditing(textField)
        
        should = self.checkIfTextField(superShould: should, shouldPerformAction: { (controller) -> Bool in
            return controller.textFieldShouldEndEditing(textField)
        })

        return should
    }
    
    override func textFieldShouldClear(_ textField: UITextField) -> Bool {
        var should = super.textFieldShouldClear(textField)
        
        should = self.checkIfTextField(superShould: should, shouldPerformAction: { (controller) -> Bool in
            return controller.textFieldShouldClear(textField)
        })

        return should
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var should = super.textFieldShouldReturn(textField)
        
        should = self.checkIfTextField(superShould: should, shouldPerformAction: { (controller) -> Bool in
            return controller.textFieldShouldReturn(textField)
        })

        return should
    }

    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var should = super.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        
        should = self.checkIfTextField(superShould: should, shouldPerformAction: { (controller) -> Bool in
            return controller.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        })
        
        return should
    }
}

fileprivate extension TextFieldControllerComposer {
    func checkIfTextField(superShould: Bool, shouldPerformAction: ( _ controller: ChainTextFieldController) -> Bool) -> Bool {
        guard !self.controllers.isEmpty else {
            return superShould
        }
 
        let composedShould: Bool

        switch logicalType {
        case .and:
            composedShould = superShould && !self.controllers.contains(where: { (c) -> Bool in
                let should = shouldPerformAction(c)
                return !should
            })
            
        case .or:
            composedShould = superShould || self.controllers.contains(where: { (c) -> Bool in
                let should = shouldPerformAction(c)
                return should
            })
        }

        return composedShould
    }
}
