//
//  WallpaperCategoryCollectionViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI

class WallpapersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let gsReference = Storage.storage().reference(forURL: C.storageURL)
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private let userContext = DataStorageProvider.sharedUserModelController.container.viewContext
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<MOWallpaperInfo> = {
        let fetchRequest: NSFetchRequest<MOWallpaperInfo> = MOWallpaperInfo.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(MOWallpaperInfo.order), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let id = category?.id {
            let predicate = NSPredicate.equalValue(key: #keyPath(MOWallpaperInfo.category.id), object: id)
            fetchRequest.predicate = predicate
        }
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.catalogContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    weak var category: MOCategory?
    
    private var numberOfWallpapers: Int {
        let frCount = fetchedResultsController.fetchedObjects?.count ?? 0
        let premiumLimit = 5
        if self.userContext.currentUser.isPremium {
            return frCount
        }
        else {
            return frCount < premiumLimit ? frCount : premiumLimit
        }
    }
    
    private var layoutWasSetup: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WallpaperCollectionViewCell.registerCellNib(in: self.collectionView)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let _ = error as NSError
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfWallpapers
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WallpaperCollectionViewCell.dequeueReusableCell(in: self.collectionView, for: indexPath)
        if let url = fetchedResultsController.object(at: indexPath).shortSourceURL {
            let islandRef = gsReference.child(url)
            cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imageView.sd_setImage(with: islandRef)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = view.frame.height
        let itemWidth = itemHeight * Constant.iphoneScreenAspectRatio
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constant.collectionMargin, bottom: 0, right: Constant.collectionMargin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.itemSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WallpapersDetailsViewController.initial()
        vc.category = self.category
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        let p = self.fetchedResultsController.fetchedObjects
        
        vc.wallpaperInfo = self.fetchedResultsController.object(at: indexPath)
        self.present(vc, animated: true)
    }
}

extension WallpapersCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        collectionView.reloadData()
    }
}

private struct Constant {
    static let collectionMargin: CGFloat = 16.0
    static let itemSpacing: CGFloat = 16.0
    static let iphoneScreenAspectRatio: CGFloat = 640.0 / 960.0
}
