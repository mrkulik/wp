//
//  IAPViewController.swift
//  BazilPapers
//
//  Created by Kulik on 4/6/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import StoreKit
import SVProgressHUD

class IAPViewController: UIViewController {
    @IBOutlet weak var rootView: UIStackView!
    
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

    func commonButtonDidPressed() {
        iapController.purchaseProduct(index: selectedSubscription)
    }
    
    @IBAction func restorePurchasesButtonDidPressed(_ sender: UIButton) {
        iapController.restorePurchases()
    }
    
    @IBAction func closeButtonDidPressed(_ sender: UIButton) {
        hideScreen()
    }
    
    private func setUserPremium() {

    }
    
    private func hideScreen() {

    }
    
}
// MARK:- IAPControllerDelegate
extension IAPViewController: IAPControllerDelegate {
    
    func tryBuyProduct() {
        SVProgressHUD.show()
    }
    
    func didPaymentCancelled() {
        SVProgressHUD.dismiss()
    }
    
    func didPurchaseProduct(product: SKProduct) {
        SVProgressHUD.dismiss()
        setUserPremium()
        hideScreen()
    }
    
    func didRestorePurchases(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        setUserPremium()
        hideScreen()
    }
    
    func didFailRestorePurchases(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    func didFailPurchaseProduct(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}
