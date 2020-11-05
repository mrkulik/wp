//
//  IAPBundle.swift
//  BazilPapers
//
//  Created by Kulik on 10/24/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation


enum IAPBundle {
    case premium_unlim
    case week4_99_3d_trial
    
    var identifier: String {
        switch self {
        case .premium_unlim:
            return "premium_unlim"
        case .week4_99_3d_trial:
            return "week4.99_3d_trial"
        }
    }
}
