//
//  UIViewController+Instance.swift
//  BazilPapers
//
//  Created by Kulik on 1/7/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

extension UIViewController {
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
