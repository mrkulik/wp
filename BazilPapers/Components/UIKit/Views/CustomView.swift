//
//  CustomView.swift
//  sberservice
//
//  Created by admin on 9/3/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit

// Usage:
// For example your class name MyMegaView
//
// 1. Subclass from this:
//  class MyMegaView: CustomView { }
//
// 2. Create .xib with the same name, it must have only ONE root view, it is your's MyMegaView
//  MyMegaView.xib
//
// 3. In .xib file MyMegaView class set as File's owner class
//
// 4. For your custom view in any other .xib or .storyboard file set MyMegaView as class type in inspector


class CustomView: UIView {
    var rootView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.makeInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        self.makeInit()
    }
    
    private func makeInit() {
        let nibName = String(describing: type(of: self))
        let views = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        
        let view = views!.first as! UIView
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
        self.rootView = view
    }
    
    private func setBackgroundColor() {
        self.setBackgroundColor(UIColor.clear)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setBackgroundColor()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setBackgroundColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setBackgroundColor()
    }
}

