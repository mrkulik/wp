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


protocol WallpapersDetailsViewControllerActionPerformer: class {
    func didPressedSaveButton(_ sender: UIButton)
}

class WallpapersDetailsViewController: UIViewController {
    
    private let gsReference = Storage.storage().reference(forURL: C.storageURL)
    
    weak var wallpaperInfo: MOWallpaperInfo?
    weak var category: MOCategory?
    
    weak var actionPerformer: WallpapersDetailsViewControllerActionPerformer?
    
    private weak var collectionViewController: WallpapersDetailsCollectionViewController?
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        self.actionPerformer?.didPressedSaveButton(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WallpapersDetailsCollectionViewController {
            self.actionPerformer = vc
            collectionViewController = vc
            vc.category = self.category
            vc.wallpaperInfo = self.wallpaperInfo
        }
    }
}
