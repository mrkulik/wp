//
//  WallpaperSubscriptionCollectionViewCell.swift
//  BazilPapers
//
//  Created by Kulik on 4/12/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit


class WallpaperSubscriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Constant.cornerRadius
        self.layer.masksToBounds = true
    }

}


private struct Constant {
    static let cornerRadius: CGFloat = 12.0
}
