//
//  UINavigationItem+Setup.swift
//  Internal
//
//  Created by wx on 7/8/18.
//  Copyright © 2018 wx. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    func setupEmptyBackTitle() {
        self.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func setupAttributedTitle(titleText: String, attributes: [NSAttributedString.Key : Any]?) {
        let titleLabel = UILabel()
        let attributedTitle = NSAttributedString(string: titleText, attributes: attributes)
        titleLabel.attributedText = attributedTitle
        self.titleView = titleLabel
    }
}
