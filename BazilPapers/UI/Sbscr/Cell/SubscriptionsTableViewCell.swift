//
//  SubscriptionsTableViewCell.swift
//  BazilPapers
//
//  Created by Kulik on 10/24/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit

class SubscriptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAdaptiveUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupAdaptiveUI() {
        if UIDevice.current.screenType == .iPhone5 {
            titleLeadingConstraint.constant = 20
            titleLabel.font = titleLabel.font.withSize(15)
        }
    }
}

