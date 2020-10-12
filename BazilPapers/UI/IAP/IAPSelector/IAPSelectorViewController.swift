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
    
    func setupPriceLabels() {
        let onetime = String(format: NSLocalizedString("%@", comment: ""), getFormattedPrice(product: IAPController.shared.productForIndex(index: 0)) ?? "")
        firstPurchasePriceLabel.text = onetime
        let monthTitle = String(format: NSLocalizedString("%@/week", comment: ""), getFormattedPrice(product: IAPController.shared.productForIndex(index: 1)) ?? "")
        secondPurchasePriceLabel.text = monthTitle
    }
    
    private func getFormattedPrice(product: SKProduct?) -> String? {
        guard let product = product else {
            return nil
        }
        
        let locale = product.priceLocale
        
        let nb = NumberFormatter()
        nb.numberStyle = .currency
        nb.locale = locale
        let p = product.price
        return nb.string(from: p)
    }
    
    private func setupSelectedUI(at index: Int) {
        componentRootViews.forEach {
            $0.borderColor = .white
        }
        componentRootViews[selectedIndex].borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
}

extension IAPSelectorViewController: ButtonTabViewControllerDelegate {
    func controller(_ controller: ButtonTabViewController, didSelectTabAtIndex index: Int) {
        setupSelectedUI(at: index)
        Analytics.logEvent("sbscr_tab_selected", parameters: ["index" : index])
    }
}
