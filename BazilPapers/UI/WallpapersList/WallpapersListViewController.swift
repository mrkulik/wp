//
//  WallpapersListViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import PopMenu
import StoreKit
import SafariServices

class WallpapersListViewController: UIViewController {

    private let menuItems: [MenuItemViewModel] = [
        .init(title: "Premium Access", image:  UIImage(named: "get-premium"), color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), type: .premiumAccess),
        .init(title: "Rate App", image: UIImage(named: "star.fill"), color:  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .rate),
        .init(title: "Support", image: UIImage(named: "support"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .support),
        .init(title: "Share", image: UIImage(named: "share"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .share),
        .init(title: "Privacy Policy", image:  UIImage(named: "privacy-policy"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .privacy)
    ]
    
    @IBOutlet weak var menuButton: UIButton!
    @IBAction func menuPressed(_ sender: UIButton) {
        let controller = PopMenuViewController(sourceView: menuButton, actions: getPopMenuDefaultActions())
        
        // Customize appearance
        controller.appearance.popMenuFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        controller.appearance.popMenuBackgroundStyle = .blurred(.dark)
        // Configure options
        controller.shouldDismissOnSelection = false
        controller.delegate = self
        
        // Present menu controller
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func getPopMenuDefaultActions() -> [PopMenuDefaultAction] {
        var result: [PopMenuDefaultAction] = []
        menuItems.forEach {
            result.append(.init(title: $0.title, image: $0.image, color: $0.color))
        }
        return result
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension WallpapersListViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        let menuItem = menuItems[index]
        switch menuItem.type {
        case .rate:
            handleRate()
        case .share:
            handleShare()
        case .privacy:
            handlePrivacyPolicy()
        case .support:
            handleSupport()
        default:
            return
        }
    }
    
    private func handleShare() {
        
    }
    
    private func handleRate() {
        SKStoreReviewController.requestReview()
    }
    
    private func handlePrivacyPolicy() {
        if let url = URL(string: "https://lovely-wallpapers.bazillabs.com/home/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    private func handleSupport() {
        if let url = URL(string: "https://lovely-wallpapers.bazillabs.com/home/faq") {
            UIApplication.shared.open(url)
        }
    }
}


struct MenuItemViewModel {
    var image: UIImage?
    var title: String?
    var color: UIColor?
    var type: MenuItemType
    
    init(title: String?, image: UIImage?, color: UIColor?, type: MenuItemType = .usual) {
        self.title = title
        self.image = image
        self.color = color
        self.type = type
    }
}

enum MenuItemType {
    case rate
    case share
    case privacy
    case support
    case usual
    case premiumAccess
}
