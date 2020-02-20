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


class WallpapersDetailsViewController: UIViewController {
    
    private let gsReference = Storage.storage().reference(forURL: Constant.storageURL)
    
    weak var wallpaperInfo: MOWallpaperInfo?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = wallpaperInfo?.sourceURL {
            let islandRef = gsReference.child(url)
            self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            self.imageView.sd_setImage(with: islandRef)
        }
    }

}

private struct Constant {
    static let storageURL: String = "gs://bazillabs-swipepappers.appspot.com"
}
