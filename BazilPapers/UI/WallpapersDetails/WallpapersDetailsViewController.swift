//
//  WallpapersDetailsViewController.swift
//  BazilPapers
//
//  Created by Kulik on 2/17/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI
import Photos


class WallpapersDetailsViewController: UIViewController {
    
    private let gsReference = Storage.storage().reference(forURL: Constant.storageURL)
    
    weak var wallpaperInfo: MOWallpaperInfo?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let image = self.imageView.image else {
            return
        }
        
        self.saveImageToAlbum(image, name: Constant.assetCollectionName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isHidden = true
        self.backButton.isHidden = true
        if let sourceURL = wallpaperInfo?.sourceURL {
            let islandRef = gsReference.child(sourceURL)
            self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            islandRef.downloadURL { url, error in
                if let _ = error {
                // Handle any errors
                } else {
                    self.imageView.sd_setImage(with: url, completed: {
                        (image, error, cacheType, url) in
                        self.saveButton.isHidden = false
                        self.backButton.isHidden = false
                    })
                }
            }
        }
    }

    func saveImageToAlbum(_ image: UIImage, name: String) {

        if let collection = fetchAssetCollection(name) {
            self.saveImageToAssetCollection(image, collection: collection)
        } else {
            // Album does not exist, create it and attempt to save the image
            PHPhotoLibrary.shared().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
            }, completionHandler: { (success: Bool, error: Error?) in
                guard success == true && error == nil else {
                    NSLog("Could not create the album")
                    if let err = error {
                        NSLog("Error: \(err)")
                    }
                    return
                }

                if let newCollection = self.fetchAssetCollection(name) {
                    self.saveImageToAssetCollection(image, collection: newCollection)
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
        }, completionHandler: { (success: Bool, error: Error?) in
            guard success == true && error == nil else {
                NSLog("Could not save the image")
                if let err = error {
                    NSLog("Error: " + err.localizedDescription)
                }
                return
            }
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success!", message: "Wallpaper saved to album: " + Constant.assetCollectionName, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: self.successPressed))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func successPressed(alert: UIAlertAction!) {
        self.navigationController?.popViewController(animated: true)
    }
}

private struct Constant {
    static let storageURL: String = "gs://bazillabs-swipepappers.appspot.com"
    static let assetCollectionName: String = "SwipePapers"
}
