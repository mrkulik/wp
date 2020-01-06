//
//  UITableViewHeaderFooterView+Table.swift
//  sberservice
//
//  Created by Kulik on 9/7/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit


extension UITableViewHeaderFooterView {
    class func dequeueReusableHeaderFooterView(in tableView: UITableView, reuseIdentifier identifier: String? = nil) -> Self? {
        return dequeueReusableHeaderFooterViewPrivate(in: tableView, reuseIdentifier: identifier ?? name)
    }
    
    private class func dequeueReusableHeaderFooterViewPrivate<T>(in tableView: UITableView, reuseIdentifier: String) -> T? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
        
        return cell as? T
    }
    
    class func registerViewNib(_ nibName: String? = nil,
                               bundle bundleOrNil: Bundle? = nil,
                               forHeaderFooterViewReuseIdentifier identifier: String? = nil,
                               in tableView: UITableView) {
        
        let nib = UINib(nibName: nibName ?? name, bundle: bundleOrNil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: identifier ?? name)
    }
    
    class func registerViewClass(forViewReuseIdentifier identifier: String? = nil,
                                 in tableView: UITableView) {
        
        tableView.register(self, forHeaderFooterViewReuseIdentifier: identifier ?? name)
    }
    
}
