//
//  IAPCollectionViewController.swift
//  BazilPapers
//
//  Created by Kulik on 4/17/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI

class IAPCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let gsReference = Storage.storage().reference(forURL: C.storageURL)
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<MOPremiumPreviewPicture> = {
        let fetchRequest: NSFetchRequest<MOPremiumPreviewPicture> = MOPremiumPreviewPicture.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(MOPremiumPreviewPicture.order), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.catalogContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WallpaperCollectionViewCell.registerCellNib(in: self.collectionView)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let _ = error as NSError
        }
        autoScroll()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func autoScroll() {
        let co = collectionView.contentOffset.x
        let no = co + 1

        UIView.animate(withDuration: 0.016, delay: 0, options: .curveEaseInOut, animations: { [weak self]() -> Void in
            self?.collectionView.contentOffset = CGPoint(x: no, y: 0)
            }) { [weak self](finished) -> Void in
                self?.autoScroll()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.fetchedResultsController.fetchedObjects?.count ?? 0) * 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = WallpaperCollectionViewCell.dequeueReusableCell(in: self.collectionView, for: indexPath)
        let itemsCount = self.fetchedResultsController.fetchedObjects?.count ?? 1
        let ip = IndexPath(row: indexPath.row % itemsCount, section: indexPath.section)
        if let url = fetchedResultsController.object(at: ip).url {
            let islandRef = gsReference.child(url)
            cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imageView.sd_setImage(with: islandRef)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = view.frame.height
        let itemWidth = itemHeight * Constant.iphoneScreenAspectRatio
//        let itemWidth = (view.frame.width - Constant.collectionMargin * 2 - Constant.itemSpacing * 2) / 3
//        let itemHeight = view.frame.height
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
}

extension IAPCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        collectionView.reloadData()
    }
}

private struct Constant {
    static let collectionMargin: CGFloat = 16.0
    static let itemSpacing: CGFloat = 5.0
    static let iphoneScreenAspectRatio: CGFloat = 640.0 / 960.0
}
