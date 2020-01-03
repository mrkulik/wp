//
//  CancelKeyboardHeaderView.swift
//  Internal
//
//  Created by wx on 5/5/18.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

protocol KeyboardHeaderButtonViewActionPerformer: class {
    func didPressedButton( _ button: UIButton, sender: KeyboardHeaderButtonView)
}

class KeyboardHeaderButtonView: UIView {
    weak var actionPerformer: KeyboardHeaderButtonViewActionPerformer?

    weak var button: UIButton! {
        didSet {
            self.button.addTarget(self, action: #selector(self.buttonDidPressed(_:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonDidPressed(_ sender: UIButton) {
        self.actionPerformer?.didPressedButton(sender, sender: self)
    }
}

