//
//  UIViewController+Instance.swift
//  Internal
//
//  Created by wx on 05.06.2018.
//  Copyright © 2018 wx. All rights reserved.
//

import UIKit

extension UIViewController {
    //TODO: RENAME
    static func initial() -> Self {
        let className = String(describing: self)
        
        let name = className.replacingOccurrences(of: "ViewController", with: "").replacingOccurrences(of: "Controller", with: "")
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return instanceInitial(from: storyboard)
    }

    //MARK: - Private

    private class func instanceInitial<T: UIViewController>(from storyboard: UIStoryboard) -> T {
        return storyboard.instantiateInitialViewController() as! T
    }
}
