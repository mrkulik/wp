//
//  WallpapersCategoryTableViewCell.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class WallpapersListTableViewCell: UITableViewCell {

    weak var containerController: UICollectionViewController?
    
    @IBOutlet weak var collectionContainerView: UIView!
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
