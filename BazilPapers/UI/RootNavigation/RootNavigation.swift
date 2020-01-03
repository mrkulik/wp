//
//  RootNavigation.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import UIKit

protocol RootNavigation: class {
    
}

extension RootNavigation where Self: UIViewController {
    
    var rootNavigationController: RootNavigationController? {
        return self.navigationController as? RootNavigationController
    }
    
    var presentingRootNavigationController: RootNavigationController? {
        var nc = self.presentingViewController as? RootNavigationController
        nc = nc ?? self.presentingViewController?.navigationController as? RootNavigationController
        
        nc = nc ?? self.presentingViewController?.presentingViewController as? RootNavigationController
        nc = nc ?? self.presentingViewController?.presentingViewController?.navigationController as? RootNavigationController

        return nc
    }
}
