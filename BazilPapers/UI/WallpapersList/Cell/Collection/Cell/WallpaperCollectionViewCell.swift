//
//  WallpaperCollectionViewCell.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI


class WallpaperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = Constant.cornerRadius
        self.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = Constant.cornerRadius
    }

}


private struct Constant {
    static let cornerRadius: CGFloat = 12.0
}
