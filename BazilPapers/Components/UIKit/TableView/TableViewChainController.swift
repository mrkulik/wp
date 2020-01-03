//
//  TableViewChainController.swift
//  sberservice
//
//  Created by admin on 9/26/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class TableViewChainController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    weak var tableView: UITableView!
    
    var nextController: (TableViewChainController)? {
        didSet {
            self.dataSource = self.nextController
            self.delegate = self.nextController
        }
    }
    //MARK: - DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let n = self.dataSource?.numberOfSections?(in: tableView) ?? 0
        return n
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let n = self.dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
        return n
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dataSource?.tableView(tableView, cellForRowAt: indexPath) else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let title = self.dataSource?.tableView?(tableView, titleForFooterInSection: section)
        return title
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = self.dataSource?.tableView?(tableView, titleForHeaderInSection: section)
        return title
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.dataSource?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let c = self.dataSource?.tableView?(tableView, canEditRowAt: indexPath) ?? false
        return c
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let c = self.dataSource?.tableView?(tableView, canMoveRowAt: indexPath) ?? false
        return c
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.dataSource?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.delegate?.tableView?(tableView, viewForHeaderInSection: section)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = self.delegate?.tableView?(tableView, viewForFooterInSection: section)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = self.delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
        return h
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let h = self.delegate?.tableView?(tableView, heightForHeaderInSection: section) ?? tableView.sectionHeaderHeight
        return h
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let h = self.delegate?.tableView?(tableView, heightForFooterInSection: section) ?? tableView.sectionFooterHeight
        return h
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = self.delegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? tableView.rowHeight
        return h
    }
    

}
