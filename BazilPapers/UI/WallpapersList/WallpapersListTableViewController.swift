//
//  WallpapersListTableViewController.swift
//  BazilPapers
//
//  Created by Kulik on 1/4/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI


class WallpapersListTableViewController: UITableViewController {

    private let catalogContext = DataStorageProvider.sharedCatalogModelController.container.viewContext
    
    private let gsReference = Storage.storage().reference(forURL: C.storageURL)
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<MOCategory> = {
        let fetchRequest: NSFetchRequest<MOCategory> = MOCategory.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.catalogContext, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WallpapersListTableViewCell.registerCellNib(in: self.tableView)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let _ = error as NSError
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height / 2.3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WallpapersListTableViewCell.dequeueReusableCell(in: self.tableView, for: indexPath)
        let category = self.fetchedResultsController.object(at: indexPath)
        let vc = WallpapersCollectionViewController.initial()
        vc.category = category
        cell.containerController = vc
        self.addChildContainer(vc, containerSubview: cell.collectionContainerView)
        
        cell.selectionStyle = .none
        cell.categoryTitleLabel.text = category.title
        if let url = category.iconURL {
            let islandRef = gsReference.child(url)
            cell.categoryImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.categoryImageView.sd_setImage(with: islandRef)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? WallpapersListTableViewCell {
            cell.containerController?.removeChildContainerFromParent()
        }
    }

}

extension WallpapersListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
