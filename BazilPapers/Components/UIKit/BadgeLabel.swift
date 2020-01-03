//
//  BadgeLabel.swift
//  Internal
//
//  Created by wx on 27.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let originalTextRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        let textInsetsRect: CGRect
        
        if let count = self.text?.count, count > 0 {
            let insets = self.makeContentInsets(originalTextRect: originalTextRect)
            let insetsRect = bounds.inset(by: insets)

            let textRect = super.textRect(forBounds: insetsRect, limitedToNumberOfLines: numberOfLines)
            textInsetsRect = textRect.inset(by: insets.invertedInsets)
        }
        else {
            textInsetsRect = originalTextRect
        }
        
        return textInsetsRect
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.size.height/2
        self.invalidateIntrinsicContentSize()
    }
    
    private func makeContentInsets(originalTextRect: CGRect) -> UIEdgeInsets {
        let size = self.bounds.size
        let radius = self.layer.cornerRadius
        let borderWidth = self.layer.borderWidth

        var hOffset = (radius + borderWidth)/2
        let vOffset = borderWidth

        if self.text?.count ?? 0 <= 1 {
            hOffset = (size.height - originalTextRect.size.width)/2
        }
        
        let textInsets = UIEdgeInsets(top: vOffset, left: hOffset, bottom: vOffset, right: hOffset)
        
        return textInsets
    }
}

fileprivate extension UIEdgeInsets {
    var invertedInsets: UIEdgeInsets {
        let insets = UIEdgeInsets(top: -self.top, left: -self.left, bottom: -self.bottom, right: -self.right)
        return insets
    }
}

