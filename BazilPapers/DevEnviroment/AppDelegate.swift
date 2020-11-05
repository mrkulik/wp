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
import GoogleMobileAds


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let nc = RootNavigationController.initial()
        nc.setRootTabs()
        window?.rootViewController = nc
        IAPController.shared.setupTransactionObserver()
        //IAPController.shared.verifyPremium()
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
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    
    

}

