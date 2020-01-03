//
//  UICollectionViewCell+Collection.swift
//  sberservice
//
//  Created by admin on 7/26/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionViewCell {
    
    class func dequeueReusableCell(in collectionView: UICollectionView, for indexPath: IndexPath, reuseIdentifier identifier: String? = nil) -> Self {
        return dequeueReusableCellPrivate(in: collectionView, for: indexPath, reuseIdentifier: identifier ?? name)
    }
    
    
    private class func dequeueReusableCellPrivate<T>(in collectionView: UICollectionView, for indexPath: IndexPath, reuseIdentifier: String) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
    
    //Mark: Register
    
    class func registerCellNib(_ nibName: String? = nil,
                               bundle bundleOrNil: Bundle? = nil,
                               forCellReuseIdentifier identifier: String? = nil,
                               in collectionView: UICollectionView) {
        
        let nib = UINib(nibName: nibName ?? name, bundle: bundleOrNil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifier ?? name)
    }
    
    class func registerCellClass(forCellReuseIdentifier identifier: String? = nil,
                                 in collectionView: UICollectionView) {
        
        collectionView.register(self, forCellWithReuseIdentifier: identifier ?? name)
    }
}

