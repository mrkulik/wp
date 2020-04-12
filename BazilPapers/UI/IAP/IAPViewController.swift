//
//  IAPViewController.swift
//  BazilPapers
//
//  Created by Kulik on 4/6/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import StoreKit
import SVProgressHUD
import Firebase


class IAPViewController: UIViewController {
    @IBOutlet weak var rootView: UIStackView!
    
    private let context = DataStorageProvider.sharedUserModelController.container.viewContext
    
    private weak var selectorViewController: IAPSelectorViewController?
    
    private var selectedSubscription: Int {
        return selectorViewController?.selectedIndex ?? 1
    }
    
    private let iapController = IAPController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iapController.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? IAPSelectorViewController {
            selectorViewController = vc
        }
    }

    @IBAction func becomePremiumPressed(_ sender: Any) {
        iapController.purchaseProduct(index: selectedSubscription)
        Analytics.logEvent("become_premium_pressed", parameters: [ : ])
    }
    
    @IBAction func restorePurchasesButtonDidPressed(_ sender: UIButton) {
        iapController.restorePurchases()
        Analytics.logEvent("restore_sbscr_pressed", parameters: [ : ])
    }
    
    @IBAction func closeButtonDidPressed(_ sender: UIButton) {
        hideScreen()
        Analytics.logEvent("close_sbscr_pressed", parameters: [ : ])
    }
    
    private func setUserPremium() {
        self.context.currentUser.isPremium = true
        try? self.context.save()
        Analytics.logEvent("became_premium", parameters: [ : ])
    }
    
    private func hideScreen() {
        self.dismiss(animated: true)
    }
    
}
// MARK:- IAPControllerDelegate
extension IAPViewController: IAPControllerDelegate {
    
    func tryBuyProduct() {
        SVProgressHUD.show()
    }
    
    func didPaymentCancelled() {
        SVProgressHUD.dismiss()
        Analytics.logEvent("payment_canceled", parameters: [ : ])
    }
    
    func didPurchaseProduct(product: SKProduct) {
        SVProgressHUD.dismiss()
        setUserPremium()
        hideScreen()
    }
    
    func didRestorePurchases(message: String) {
        SVProgressHUD.showSuccess(withStatus: message, maskType: SVProgressHUDMaskType.black)
        setUserPremium()
        hideScreen()
    }
    
    func didFailRestorePurchases(message: String) {
        SVProgressHUD.showError(withStatus: message)
        self.context.currentUser.isPremium = false
        try? self.context.save()
    }
    
    func didFailPurchaseProduct(message: String) {
        SVProgressHUD.showError(withStatus: message)
        Analytics.logEvent("payment_failed", parameters: [ : ])
    }
}
