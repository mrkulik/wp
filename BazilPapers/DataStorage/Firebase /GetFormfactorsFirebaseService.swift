//
//  GetFormfactorsFirebaseService.swift
//  BazilPapers
//
//  Created by Kulik on 2/5/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import Foundation
import Firebase
import CoreData


class GetFormfactorsFirebaseService {
    private let dbConfigsFormFactorsReference: DatabaseReference = Database.database(url: Constant.configsFormFactorsURL).reference()
    
    private var formFactorsReferencePath: DatabaseReference {
        return dbConfigsFormFactorsReference.child("formFactors")
    }
    
    func observeConfigsCatalogtWithSingleEvent() {
        formFactorsReferencePath.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let snapshot = snapshot.value as? [[String : Any]] else {
                return
            }
            
            let formFactor = snapshot.first { (ff) -> Bool in
                guard let models = ff["models"] as? [String] else {
                    return false
                }
                
                let currentModel = models.first { (modelName) -> Bool in
                    return modelName == UIDevice.modelName
                }
                return currentModel != nil ? true : false
            }
            
            let defaultFormFactor = snapshot.first { (ff) -> Bool in
                guard let isDefault = ff["isDefault"] as? Bool else {
                    return false
                }
                
                return isDefault
            }
            
            guard let formFactorValue = formFactor?["key"] as? String else {
                guard let defaultFormFactorValue = defaultFormFactor?["key"] as? String else {
                    return
                }
                
                UserDefaults.standard.setValue(defaultFormFactorValue, forKeyPath: "formFactor")
                return
            }
            
            UserDefaults.standard.setValue(formFactorValue, forKeyPath: "formFactor")
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
}

private struct Constant {
    static let configsFormFactorsURL: String = "https://configs-form-factors.firebaseio.com/"
}
