//
//  IAPManager.swift
//  BazilPapers
//
//  Created by Kulik on 3/15/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import StoreKit

protocol IAPControllerDelegate: class {
    func tryBuyProduct()
    func didPaymentCancelled()
    func didPurchaseProduct(product: SKProduct)
    func didRestorePurchases(message: String)
    func didFailRestorePurchases(message: String)
    func didFailPurchaseProduct(message: String)
    func productsUpdated()
}

class IAPController {
    // MARK: - Property
    weak var delegate: IAPControllerDelegate?
    private let sharedSecret = "7d1ffdfce2f94ff591476219892ce9be"
    private let productIds = ["premiumforever", "month1.99", "year3.99"]
    static var skProducts: [SKProduct] = [] {
        didSet {
            
        }
    }
    private var appleValidator: AppleReceiptValidator {
        return AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
    }
    // MARK: - Methodts
    static func setupTransactionObserver() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                       case .failed, .purchasing, .deferred:
                           break
                       @unknown default:
                            break
                }
            }
        }
        getProductsInfo()
    }
    
    private static func getProductsInfo() {
        let productsForInfo = Set(["premiumforever", "month1.99", "year3.99"])
        SwiftyStoreKit.retrieveProductsInfo(productsForInfo) { (result) in
            skProducts = result.retrievedProducts.sorted(by: { (sk1, sk2) -> Bool in
                return sk1.price.floatValue < sk2.price.floatValue
            })
        }
    }
    
    func purchaseProduct(index: Int) {
        delegate?.tryBuyProduct()
        SwiftyStoreKit.purchaseProduct(productIds[index]) { (result) in
            if case .success(let purchase) = result {
                self.delegate?.didPurchaseProduct(product: purchase.product)
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
            }
            else if case .error(let error) = result {
                switch error.code {
                case .paymentCancelled:
                    self.delegate?.didPaymentCancelled()
                default:
                    self.delegate?.didFailPurchaseProduct(message: error.localizedDescription)
                }
            }
        }
    }
    
    func restorePurchases() {
        delegate?.tryBuyProduct()
        SwiftyStoreKit.restorePurchases(atomically: true) { (results) in
            if results.restoreFailedPurchases.count > 0 {
                let error = results.restoreFailedPurchases[0].0
                self.delegate?.didFailRestorePurchases(message: error.localizedDescription)
            }
            else if results.restoredPurchases.count > 0 {
                SwiftyStoreKit.verifyReceipt(using: self.appleValidator) { (verifyResult) in
                    switch verifyResult {
                    case .success(let receipt):
                        self.verifyReceipt(receipt: receipt)
                    case .error(let error):
                        self.delegate?.didFailRestorePurchases(message: error.localizedDescription)
                    }
                }
            }
            else {
                self.delegate?.didFailRestorePurchases(message: NSLocalizedString("Nothing to Restore", comment: ""))
            }
        }
    }
    
    func verifySubscription(completion: @escaping(VerifySubscriptionResult?) ->()) {
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { (result) in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: Set(self.productIds), inReceipt: receipt)
                completion(purchaseResult)
            case .error(_):
                completion(nil)
                break
            }
        }
    }
    
    func verifyReceipt(receipt: ReceiptInfo) {
    guard
        let latestReceiptObjects = (receipt["latest_receipt_info"] as? [AnyObject]),
        let receiptDict = latestReceiptObjects.last as? [String: AnyObject],
        let productId = receiptDict["product_id"] as? String
        else
    {
        delegate?.didFailRestorePurchases(message: NSLocalizedString("Receipt verification failed", comment: ""))
        return
    }
    
    let varificationResult = SwiftyStoreKit.verifySubscription(ofType: .autoRenewable,
                                                                   productId: productId,
                                                                   inReceipt: receipt)
        switch varificationResult {
        case .purchased(let expiryDate, let items):
            print("is valid until \(expiryDate)\n\(items)\n")
            delegate?.didRestorePurchases(message: NSLocalizedString("Your subscription restored", comment: ""))
            
        case .expired(let expiryDate, let items):
            print("expiried \(expiryDate)(expiryDate)\n\(items)\n")
            delegate?.didFailRestorePurchases(message: NSLocalizedString("Your subscription has expired", comment: ""))
            
        case .notPurchased:
            print("notPurchased")
            delegate?.didFailRestorePurchases(message: NSLocalizedString("Not Purchased", comment: ""))
        }
    }
}
