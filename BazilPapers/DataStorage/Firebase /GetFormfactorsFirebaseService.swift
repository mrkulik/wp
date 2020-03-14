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
    private let dbConfigsFormFactorsReference: DatabaseReference = Database.database(url: C.configsFormFactorsURL).reference()
    
    private var formFactorsReferencePath: DatabaseReference {
        return dbConfigsFormFactorsReference
    }
    
    func observeFormFactorsWithSingleEvent() {
        formFactorsReferencePath.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let snapshot = snapshot.value as? [String : Any] else {
                return
            }
            
            guard let formFactors = snapshot["formFactors"] as? [[String : Any]] else {
                return
            }
            
            let formFactor = formFactors.first { (ff) -> Bool in
                guard let models = ff["models"] as? [String] else {
                    return false
                }
                
                let currentModel = models.first { (modelName) -> Bool in
                    return modelName == UIDevice.modelName
                }
                return currentModel != nil ? true : false
            }
            
            var result: String?
            if let ff = formFactor {
                result = ff["key"] as? String
            }
            else {
                result = snapshot["defaultFormFactorKey"] as? String
            }
            
            UserDefaults.standard.setValue(result, forKeyPath: "formFactor")
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
}
