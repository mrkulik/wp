//
//  TableViewComposer.swift
//  sberservice
//
//  Created by admin on 9/26/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class TableViewDataSourceComposer: TableViewChainController {
  
   private (set) var controllers: [TableViewChainController] = []
    
    override init() {
        super.init()
    }
    
    func setupTableView(_ tableView: UITableView, with sections: [TableViewChainController]) {
        self.tableView = tableView
        self.controllers = sections
        
        controllers.forEach { (controller) in
            controller.tableView = self.tableView
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return controllers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let c = self.controllers[section]
        let n = c.tableView(tableView, numberOfRowsInSection: section)
        
        return n
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = self.controllers[indexPath.section]
        let cell = c.tableView(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let c = self.controllers[section]
        let title = c.tableView(tableView, titleForHeaderInSection: section)
        return title
    }
   
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let c = self.controllers[section]
        let title = c.tableView(tableView, titleForFooterInSection: section)
        return title
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.controllers.forEach { (c) in
            c.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let c = self.controllers[indexPath.section]
        let isCan = c.tableView(tableView, canEditRowAt: indexPath)
        return isCan
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let c = self.controllers[indexPath.section]
        let isCan = c.tableView(tableView, canEditRowAt: indexPath)
        return isCan
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        controllers.forEach { (c) in
            c.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
        }
    }
    
    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controllers.forEach { (c) in
            c.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        controllers.forEach { (c) in
            c.tableView(tableView, didDeselectRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let c = self.controllers[section]
        let v = c.tableView(tableView, viewForHeaderInSection: section)
        return v
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let c = self.controllers[section]
        let v = c.tableView(tableView, viewForFooterInSection: section)
        return v
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let c = self.controllers[indexPath.section]
        let h = c.tableView(tableView, heightForRowAt: indexPath)
        return h
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let c = self.controllers[section]
        let h = c.tableView(tableView, heightForHeaderInSection: section)
        return h
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let c = self.controllers[section]
        let h = c.tableView(tableView, heightForFooterInSection: section)
        return h
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let c = self.controllers[indexPath.section]
        let h = c.tableView(tableView, estimatedHeightForRowAt: indexPath)
        return h
    }
    
}
