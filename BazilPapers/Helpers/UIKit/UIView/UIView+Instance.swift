//
//  UIView+Instance.swift
//  Internal
//
//  Created by wx on 4/4/19.
//  Copyright © 2019 wx. All rights reserved.
//

import Foundation
import UIKit

typealias LoadOptions = [AnyHashable: Any]

extension UIView {
    
    class var name: String {
        return String(describing: self)
    }
    
    class func instance(from nibType: UIView.Type, owner: Any? = nil, options: LoadOptions? = nil, bundle: Bundle = Bundle.main) -> Self {
        
        return instance(from: nibType.name, owner: owner, options: options, bundle: bundle)
    }
    
    class func instance(from nibName: String? = nil, owner: Any? = nil, options: LoadOptions? = nil, bundle: Bundle = Bundle.main) -> Self {
        
        return view(from: nibName ?? name, owner: owner, options: options, bundle: bundle)
    }
    
    
    //MARK: - Private
    
    private class func view<T: UIView>(from nibName: String, owner: Any?, options: LoadOptions?, bundle: Bundle = Bundle.main) -> T {
        
        return bundle.loadNibNamed(nibName, owner: owner, options: options as? [UINib.OptionsKey : Any])?.first(where: { $0 is T }) as! T
    }
}

