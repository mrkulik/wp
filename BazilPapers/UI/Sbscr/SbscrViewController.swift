//
//  SbscrViewController.swift
//  BazilPapers
//
//  Created by Kulik on 10/24/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import SVProgressHUD
import StoreKit


protocol SbscrViewControllerDelegate: class {
    func didPurchased()
}


class SbscrViewController: UIViewController {
    
    private let context = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    weak var delegate: SbscrViewControllerDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    private let rows: [Row] = [.newSounds, .sounds, .recorder, .personalSounds]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        IAPController.shared.delegate = self
        IAPController.shared.getProductsInfo()
        
        setupInitialUI()
        setupAdaptiveUI()
        
        SubscriptionsTableViewCell.registerCellNib(in: tableView)
    }
    
    // MARK: - IBActions
    @IBAction func didPressedExitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressedRestorePurchasesButton(_ sender: UIButton) {
        IAPController.shared.restorePurchases()
    }
    
    @IBAction func didPressedContinueButton(_ sender: UIButton) {
        IAPController.shared.purchaseProduct(index: 0)
    }
    
    @IBAction func didPressedTermsOfUse(_ sender: UIButton) {
        if let url = URL(string: "https://mysounddelve.com/user-agreement/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didPressedPrivacyPolicy(_ sender: UIButton) {
        if let url = URL(string: "https://mysounddelve.com/privacy-statement/") {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - UI
    private func setupInitialUI() {
        continueButton.cornerRadius = continueButton.frame.size.height / 2
        setupPriceLabel()
    }
    
    private func setupAdaptiveUI() {
        if UIDevice.current.screenType == .iPhone5 {
            tableViewBottomConstraint.constant = 10
            stackViewBottomConstraint.constant = 12
            titleLabel.font = titleLabel.font.withSize(25)
            continueButtonBottomConstraint.constant = 10
            titleLabel.text = NSLocalizedString("Premium Plan Full Access", comment: "Premium Plan Full Access")
            titleBottomConstraint.constant = 15
            titleLeadingConstraint.constant = 20
        }
        
        if UIDevice.current.screenType == .iPhone8 {
            tableViewBottomConstraint.constant = 15
        }
        
    }
    
    // MARK: - Functions
    private func setUserPremium(_ isPremium: Bool) {
        self.context.currentUser.isPremium = isPremium
        try? self.context.save()
    }
    
    private func setupPriceLabel() {
//        guard let price = IAPController.shared.getFormattedPrice() else {
//            priceLabel.text = ""
//            return
//        }
//
//        priceLabel.textColor = .white
//        priceLabel.numberOfLines = 0
//        priceLabel.lineBreakMode = .byWordWrapping
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.12
//
//        priceLabel.textAlignment = .center
//
//        priceLabel.attributedText = NSMutableAttributedString(string: "Try 3 days for free.\nThen \(price) monthly, cancel anytime", attributes: [NSAttributedString.Key.kern: -0.04, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

// MARK: - IAPControllerDelegate
extension SbscrViewController: IAPControllerDelegate {
    func productsUpdated() {
        self.setupPriceLabel()
    }
    
    func tryBuyProduct() {
        SVProgressHUD.show()
    }
    
    func didPaymentCancelled() {
        SVProgressHUD.dismiss()
    }
    
    func didPurchaseProduct(product: SKProduct) {
        SVProgressHUD.dismiss()
        setUserPremium(true)
        
        self.dismiss(animated: true, completion: {
            self.delegate?.didPurchased()
        })
    }
    
    func didRestorePurchases(message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
        setUserPremium(true)
        
        self.dismiss(animated: true, completion: {
            self.delegate?.didPurchased()
        })
    }
    
    func didFailRestorePurchases(message: String) {
        SVProgressHUD.showError(withStatus: message)
        setUserPremium(false)
    }
    
    func didFailPurchaseProduct(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SbscrViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SubscriptionsTableViewCell.dequeueReusableCell(in: tableView, for: indexPath)
        cell.titleLabel.text = rows[indexPath.row].title
        cell.specialLabel.isHidden = !rows[indexPath.row].uniqueTextNeeded
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

// MARK:-  Row
fileprivate enum Row {
    case newSounds
    case sounds
    case wallpapers
    case shake
    case recorder
    case personalSounds
    
    var title: String? {
        switch self {
        case .newSounds:
            return NSLocalizedString("All New Sounds", comment: "")
        case .sounds:
             return NSLocalizedString("1000+ Constantly Updated Sounds", comment: "")
        case .wallpapers:
             return NSLocalizedString("Set Custom Wallpapers", comment: "")
        case .shake:
             return NSLocalizedString("Shake Device to Roll the Dice", comment: "")
        case .recorder:
             return NSLocalizedString("Personal Sound Recorder", comment: "")
        case .personalSounds:
             return NSLocalizedString("Unlimited Personal Sounds Upload ", comment: "")
        }
    }
    
    var uniqueTextNeeded: Bool {
        switch self {
        case .newSounds:
            return true
        default:
            return false
        }
    }
}

