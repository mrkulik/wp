//
//  ClosuredBarButtonItem.swift
//  sberservice
//
//  Created by admin on 8/6/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

class ClosuredBarButtonItem: UIBarButtonItem {
    var actionClosure: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(image: UIImage?, actionClosure: (() -> Void)?) {
        super.init()
        self.image = image
        self.style = .plain
        self.target = self
        self.action = #selector(self.didTapButton)
        
        self.actionClosure = actionClosure
    }
    
    @objc private func didTapButton() {
        guard let closure = self.actionClosure else {
            return
        }
        
        closure()
    }
}
