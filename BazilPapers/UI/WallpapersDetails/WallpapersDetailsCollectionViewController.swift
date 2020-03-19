//
//  WallpapersDetailsCollectionViewController.swift
//  BazilPapers
//
//  Created by Kulik on 3/15/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI
import Photos



class WallpapersDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let gsReference = Storage.storage().reference(forURL: C.storageURL)
    
    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
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
    weak var wallpaperInfo: MOWallpaperInfo?
    
    
    private var numberOfWallpapers: Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    private var layoutWasSetup: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WallpapersDetailsCollectionViewCell.registerCellNib(in: self.collectionView)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let _ = error as NSError
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let startObject = self.wallpaperInfo,
            let startIP = self.fetchedResultsController.indexPath(forObject: startObject) {
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: startIP, at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfWallpapers
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = WallpapersDetailsCollectionViewCell.dequeueReusableCell(in: self.collectionView, for: indexPath)
        if let url = fetchedResultsController.object(at: indexPath).sourceURL {
            let islandRef = gsReference.child(url)
            cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.imageView.sd_setImage(with: islandRef)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
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

extension WallpapersDetailsCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
    }
}

private struct Constant {
    static let assetCollectionName: String = "SwipePapers"
    static let collectionMargin: CGFloat = 0
    static let itemSpacing: CGFloat = 0
}


extension WallpapersDetailsCollectionViewController {
    func saveImageToAlbum(_ image: UIImage, name: String) {

        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            save(image, name)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ [weak self]
                (newStatus) in
                DispatchQueue.main.async {
                    if newStatus ==  PHAuthorizationStatus.authorized {
                        self?.save(image, name)
                    }else{
                        print("User denied")
                    }
                }})
            break
        case .restricted:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            break
        case .denied:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            break
        }
        
    }

    func save(_ image: UIImage, _ name: String) {
        if let collection = fetchAssetCollection(name) {
            self.saveImageToAssetCollection(image, collection: collection)
        } else {
            // Album does not exist, create it and attempt to save the image
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            }, completionHandler: { [weak self] (success: Bool, error: Error?) in
                guard success == true && error == nil else {
                    NSLog("Could not create the album")
                    if let err = error {
                        NSLog("Error: \(err)")
                    }
                    return
                }

                if let newCollection = self?.fetchAssetCollection(name) {
                    self?.saveImageToAssetCollection(image, collection: newCollection)
                }
            })
        }
    }

    func fetchAssetCollection(_ name: String) -> PHAssetCollection? {

        let fetchOption = PHFetchOptions()
        fetchOption.predicate = NSPredicate(format: "title == '" + name + "'")

        let fetchResult = PHAssetCollection.fetchAssetCollections(
            with: PHAssetCollectionType.album,
            subtype: PHAssetCollectionSubtype.albumRegular,
            options: fetchOption)

        return fetchResult.firstObject
    }

    func saveImageToAssetCollection(_ image: UIImage, collection: PHAssetCollection) {

        PHPhotoLibrary.shared().performChanges({

            let creationRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)
            if let request = PHAssetCollectionChangeRequest(for: collection),
                let placeHolder = creationRequest.placeholderForCreatedAsset {
                request.addAssets([placeHolder] as NSFastEnumeration)
            }
        }, completionHandler: { [weak self] (success: Bool, error: Error?) in
            guard success == true && error == nil else {
                NSLog("Could not save the image")
                if let err = error {
                    NSLog("Error: " + err.localizedDescription)
                }
                return
            }
            
            self?.showSuccessAlert()
        })
    }
    
    private func showSuccessAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success!", message: "Wallpaper saved to album: " + Constant.assetCollectionName, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: self.successPressed))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successPressed(alert: UIAlertAction!) {
        self.presentedViewController?.dismiss(animated: true)
    }
}


extension WallpapersDetailsCollectionViewController: WallpapersDetailsViewControllerActionPerformer {
    
    func didPressedSaveButton(_ sender: UIButton) {
        if let ip = self.collectionView.centerCellIndexPath,
            let c = self.collectionView.cellForItem(at: ip) as? WallpapersDetailsCollectionViewCell,
        let image = c.imageView.image {
            saveImageToAlbum(image, name: Constant.assetCollectionName)
        }
        
    }
    
}

extension UICollectionView {

var centerPoint : CGPoint {

    get {
        return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
    }
}

var centerCellIndexPath: IndexPath? {

    if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
        return centerIndexPath
    }
    return nil
}
}
