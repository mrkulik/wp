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
    
    @IBOutlet var componentRootViews: [UIView]!
    @IBOutlet var subscriptionButtons: [UIButton]! {
        didSet {
            tabButtons = subscriptionButtons
            subscriptionButtons.forEach{ $0.tintColor = .clear }
        }
    }
    @IBOutlet weak var firstPurchasePriceLabel: UILabel!
    @IBOutlet weak var secondPurchasePriceLabel: UILabel!
    @IBOutlet weak var thirdPurchasePriceLabel: UILabel!
    
    var selectedIndex: Int {
        return tabButtons.firstIndex(where: { $0.isSelected }) ?? 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        delegate = self
    }
    
    private func setupInitialUI() {
        setupPriceLabels()
        
        setSelection(atIndex: 1)
        setupSelectedUI(at: selectedIndex)
        componentRootViews.forEach {
            $0.cornerRadius = 8
            $0.borderWidth = 3
        }
    }
    
    private func setupPriceLabels() {
        guard IAPController.skProducts.count == subscriptionButtons.count else {
            return
        }
        
        let onetime = String(format: NSLocalizedString("%@", comment: ""), getFormattedPrice(product: IAPController.skProducts[0]) ?? "$5.99")
        firstPurchasePriceLabel.text = onetime
        let monthTitle = String(format: NSLocalizedString("then %@\n/ month", comment: ""), getFormattedPrice(product: IAPController.skProducts[1]) ?? "$1.99")
        secondPurchasePriceLabel.text = monthTitle
        let yearTitle = String(format: NSLocalizedString("%@", comment: ""), getFormattedPrice(product: IAPController.skProducts[2]) ?? "$3.99")
        thirdPurchasePriceLabel.text = yearTitle
    }
    
    private func getFormattedPrice(product: SKProduct) -> String? {
        let nb = NumberFormatter()
        nb.numberStyle = .currency
        nb.locale = product.priceLocale
        return nb.string(from: product.price)
    }
    
    private func setupSelectedUI(at index: Int) {
        componentRootViews.forEach {
            $0.borderColor = .gray
        }
        componentRootViews[selectedIndex].borderColor = .orange
    }
}

extension IAPSelectorViewController: ButtonTabViewControllerDelegate {
    func controller(_ controller: ButtonTabViewController, didSelectTabAtIndex index: Int) {
        setupSelectedUI(at: index)
    }
}
