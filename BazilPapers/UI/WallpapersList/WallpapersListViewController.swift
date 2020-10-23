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

    private let context = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private var menuItems: [MenuItemViewModel] = .init()
    
    @IBOutlet weak var menuButton: UIButton!
    @IBAction func menuPressed(_ sender: UIButton) {
        let menuAppearance: PopMenuAppearance = .init()
        menuAppearance.popMenuActionCountForScrollable = 7
        
        let controller = PopMenuViewController(sourceView: menuButton, actions: getPopMenuDefaultActions(), appearance: menuAppearance)
        
        // Customize appearance
        controller.appearance.popMenuFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        controller.appearance.popMenuBackgroundStyle = .blurred(.dark)
        // Configure options
        controller.shouldDismissOnSelection = true
        controller.delegate = self

        // Present menu controller
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuDataSource()
    }
    
    private func getPopMenuDefaultActions() -> [PopMenuDefaultAction] {
        var result: [PopMenuDefaultAction] = []
        menuItems.forEach {
            result.append(.init(title: $0.title, image: $0.image, color: $0.color))
        }
        return result
    }

    private func setupMenuDataSource() {
        self.menuItems = [
            .init(title: "Rate App", image: #imageLiteral(resourceName: "Star"), color:  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .rate),
            .init(title: "Share", image: #imageLiteral(resourceName: "share"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .share),
            .init(title: "Support", image: #imageLiteral(resourceName: "support"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .support),
            .init(title: "Privacy Policy", image:  #imageLiteral(resourceName: "privacy-policy"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .privacy),
            .init(title: "Terms Of Use", image:  #imageLiteral(resourceName: "eula"), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), type: .terms)
        ]
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
        case .premiumAccess:
            handlePremium()
        case .terms:
            handleTerms()
        default:
            return
        }
    }
    
    private func handleShare() {
        let message = "Message goes here."
        //Set the link to share.
        if let link = NSURL(string: "http://itunes.apple.com/app/id1502856671")
        {
            let activityVC = UIActivityViewController(activityItems: [message,link], applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            if let popoverController = activityVC.popoverPresentationController {
                popoverController.sourceView = activityVC.view
                popoverController.sourceRect = CGRect(x: activityVC.view.bounds.midX, y: activityVC.view.bounds.midY, width: 0, height: activityVC.view.bounds.bottom)
                popoverController.permittedArrowDirections = []
            }
            
            self.presentedViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func handleRate() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/1502856671") {
            UIApplication.shared.open(url)
        }
    }
    
    private func handlePrivacyPolicy() {
        if let url = URL(string: "https://lovely-wallpapers.bazillabs.com/home/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    private func handleTerms() {
        if let url = URL(string: "https://lovely-wallpapers.bazillabs.com/home/therms-of-use") {
            UIApplication.shared.open(url)
        }
    }
    
    private func handleSupport() {
        if let url = URL(string: "https://lovely-wallpapers.bazillabs.com/home/faq") {
            UIApplication.shared.open(url)
        }
    }
    
    private func handlePremium() {
        let vc = IAPViewController.initial()
        vc.modalPresentationStyle = .fullScreen
        self.presentedViewController?.present(vc, animated: true)
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
    case terms
}
