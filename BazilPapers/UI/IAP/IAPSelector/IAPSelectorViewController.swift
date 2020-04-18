//
//  IAPSelectorViewController.swift
//  BazilPapers
//
//  Created by Kulik on 4/6/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import StoreKit
import Firebase

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
    
    @IBOutlet weak var secondPurchaseWeekPrice: UILabel!
    @IBOutlet weak var thirdPurchaseWeekPrice: UILabel!
    
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
            $0.cornerRadius = 12
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
        
        let secondWeekPrice = String(format: NSLocalizedString("%@/week", comment: ""), getWeekPrice(product: IAPController.skProducts[1], divider: 4) ?? "$0.49")
        secondPurchaseWeekPrice.text = secondWeekPrice
        let thirdWeekPrice = String(format: NSLocalizedString("%@/week", comment: ""), getWeekPrice(product: IAPController.skProducts[2], divider: 52) ?? "$0.08")
        thirdPurchaseWeekPrice.text = thirdWeekPrice
    }
    
    private func getFormattedPrice(product: SKProduct) -> String? {
        let nb = NumberFormatter()
        nb.numberStyle = .currency
        nb.locale = product.priceLocale
        return nb.string(from: product.price)
    }
    
    private func getWeekPrice(product: SKProduct, divider: NSDecimalNumber) -> String? {
        let nb = NumberFormatter()
        nb.numberStyle = .currency
        nb.locale = product.priceLocale
        let price = product.price.dividing(by: divider)
        return nb.string(from: price)
    }
    
    private func setupSelectedUI(at index: Int) {
        componentRootViews.forEach {
            $0.borderColor = .white
        }
        componentRootViews[selectedIndex].borderColor = #colorLiteral(red: 0.9512905478, green: 0.6862642765, blue: 0.1313454807, alpha: 1)
    }
}

extension IAPSelectorViewController: ButtonTabViewControllerDelegate {
    func controller(_ controller: ButtonTabViewController, didSelectTabAtIndex index: Int) {
        setupSelectedUI(at: index)
        Analytics.logEvent("sbscr_tab_selected", parameters: ["index" : index])
    }
}
