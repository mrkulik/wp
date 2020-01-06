//
//  UITableViewCell+Table.swift
//  BazilPapers
//
//  Created by Kulik on 1/7/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    //MARK: - Dequeue
    
    class func dequeueReusableCell(in tableView: UITableView, for indexPath: IndexPath, reuseIdentifier identifier: String? = nil) -> Self {
        return dequeueReusableCellPrivate(in: tableView, for: indexPath, reuseIdentifier: identifier ?? name)
    }
    
    
    private class func dequeueReusableCellPrivate<T>(in tableView: UITableView, for indexPath: IndexPath, reuseIdentifier: String) -> T {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell as! T
    }
    
    
    //Mark: Register
    
    class func registerCellNib(_ nibName: String? = nil,
                               bundle bundleOrNil: Bundle? = nil,
                               forCellReuseIdentifier identifier: String? = nil,
                               in tableView: UITableView) {
        
        let nib = UINib(nibName: nibName ?? name, bundle: bundleOrNil)
        tableView.register(nib, forCellReuseIdentifier: identifier ?? name)
    }
    
    class func registerCellClass(forCellReuseIdentifier identifier: String? = nil,
                                 in tableView: UITableView) {
        
        tableView.register(self, forCellReuseIdentifier: identifier ?? name)
    }
}

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

