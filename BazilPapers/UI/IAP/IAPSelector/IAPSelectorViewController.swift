//
//  IAPSelectorViewController.swift
//  BazilPapers
//
//  Created by Kulik on 4/6/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import StoreKit

class IAPSelectorViewController: ButtonTabViewController {
    
    @IBOutlet var subscriptionButtons: [UIButton]! {
        didSet {
            tabButtons = subscriptionButtons
            subscriptionButtons.forEach{ $0.tintColor = .clear }
        }
    }
    
    var selectedIndex: Int {
        return tabButtons.firstIndex(where: { $0.isSelected }) ?? 1
             
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPriceLabels()
        setSelection(atIndex: 1)
        delegate = self
    }
    
    private func setupUI() {
        setupPriceLabels()
    }
    
    private func setupPriceLabels() {
        guard IAPController.skProducts.count == subscriptionButtons.count else {
            return
        }
        
        
        
        let monthTitle = String(format: NSLocalizedString("%@\n/ month", comment: ""), getFormattedPrice(product: IAPController.skProducts[0]) ?? 9.99)
        
        let yearTrialTitle = String(format: NSLocalizedString("then %@\n/ year", comment: ""), getFormattedPrice(product: IAPController.skProducts[1]) ?? 49.99)
        
        let yearWithoutTrialTitle = String(format: NSLocalizedString("%@\n/ year", comment: ""), getFormattedPrice(product: IAPController.skProducts[2]) ?? 29.99)
    }
    
    private func getFormattedPrice(product: SKProduct) -> String? {
        let nb = NumberFormatter()
        nb.numberStyle = .currency
        nb.locale = product.priceLocale
        return nb.string(from: product.price)
    }
}

extension IAPSelectorViewController: ButtonTabViewControllerDelegate {
    func controller(_ controller: ButtonTabViewController, didSelectTabAtIndex index: Int) {
        
    }
}
