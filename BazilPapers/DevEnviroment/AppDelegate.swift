//
//  AppDelegate.swift
//  BazilPapers
//
//  Created by Kulik on 1/3/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let context = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let nc = RootNavigationController.initial()
        nc.setRootTabs()
        window?.rootViewController = nc
        IAPController.shared.setupTransactionObserver()
        self.verifyPremium()
        FirebaseApp.configure()
        DataStorageProvider.loadSharedStores()
        let getFormfactorsFirebaseService = GetFormfactorsFirebaseService()
        getFormfactorsFirebaseService.observeFormFactorsWithSingleEvent()
        
        let catalogFirebaseService = GetCategoriesFirebaseService()
        catalogFirebaseService.observeConfigsCatalogWithSingleEvent()
        
        let wallpapersFirebaseService = GetWallpapersListFirebaseService()
        wallpapersFirebaseService.observeConfigsCatalogWithSingleEvent()
        
        let premiumPictureFirebaseService = GetPremiumCategoriesFirebaseService()
        premiumPictureFirebaseService.observeConfigsCatalogWithSingleEvent()
        
        SVProgressHUD.setMinimumDismissTimeInterval(0.7)
        SVProgressHUD.setMaximumDismissTimeInterval(0.7)
        return true
    }
    
    
    private func verifyPremium() {
        IAPController.shared.verifySubscription { (result) in
            guard let result = result else {
                return
            }

            switch result {
            case .purchased:
                self.context.currentUser.isPremium = true
                
            case .expired:
                self.context.currentUser.isPremium = false
                
            case .notPurchased:
                self.context.currentUser.isPremium = false
            }
        
            try? self.context.save()
        }
    }

}

