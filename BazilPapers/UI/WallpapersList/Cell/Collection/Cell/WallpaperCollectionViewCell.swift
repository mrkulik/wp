//
//  WallpaperCollectionViewCell.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class WallpaperCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Constant.cornerRadius
        self.layer.masksToBounds = true
    }

}


private struct Constant {
    static let cornerRadius: CGFloat = 12
}
