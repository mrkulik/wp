//
//  ManageInteractionView.swift
//  Internal
//
//  Created by wx on 31.08.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation
import UIKit

protocol ManageInteractionViewDelegate: class {
    func view( _ view: ManageInteractionView, shouldHitTestAtPoint point:CGPoint) -> Bool
}

class ManageInteractionView: UIView {
    
    weak var delegate: ManageInteractionViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let should = self.delegate?.view(self, shouldHitTestAtPoint: point) ?? false
        
        guard should else {
            return nil
        }
        
        return super.hitTest(point, with: event)
    }
}

